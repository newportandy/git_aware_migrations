desc 'Run migrations in their git snapshot'
namespace :git_aware_migrations do
  task :run => :environment do
    GitAwareMigrations::Runner.run
  end
end
