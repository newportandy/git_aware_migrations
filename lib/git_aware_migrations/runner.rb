module GitAwareMigrations
  module Runner
    class << self
      def run
        if filenames.empty?
          bail 'No migrations to run'
        end
        alert "Running migrations for the following files:\n#{filenames.join("\n")}"
        checkout "master"
        revisions.each_with_index do |revision, index|
          filename = filenames[index]
          pid = fork do
            checkout revision
            run_migration filename
          end
          Process.wait(pid)
          if $?.exitstatus != 0
            bail "Error occurred while processing #{filename} at git revision #{revision}", 1
          end
        end
        bail('Finished running migrations')
      end

      private

      def pending_migrations
        @pending_migrations ||= ActiveRecord::Migrator.new(:up, ActiveRecord::Migrator.migrations_paths).pending_migrations
      end

      def filenames
        @filenames ||= pending_migrations.collect(&:filename)
      end

      def version(filename)
        @versions ||= {}
        @versions[filename] ||= pending_migrations.find{|migration| migration.filename == filename}.version
      end

      def revisions
        @revisions = filenames.collect { |filename| `git log -1 --format=oneline #{filename} | cut -f 1 -d ' ' -`}
      end

      def checkout(revision)
        alert "Checking out #{revision}"
        system "git checkout #{revision}"
      end

      def run_migration(filename)
        alert "Running migration for file #{filename} - version #{version(filename)}"
        system "bundle exec rake db:migrate:up VERSION=#{version(filename)}"
      end

      def alert(message)
        puts "\n***** #{message}"
      end

      def bail(message, statuscode = 0)
        alert message
        checkout "master"
        exit statuscode
      end
    end
  end
end
