# Git Aware Migrations

Migrates your database from the git revision the migration was completed in.

Do this:

      // Gemfile
      group :development do
        gem 'git_aware_migrations', :git => 'git://github.com/newporta/git_aware_migrations.git'
      end

      //command line
      rake git_aware_migrations:run


If you can't think of a reason this would ever be useful then you're not
the target market...

TODO

* Skip schema dump after every migration.
* Test
