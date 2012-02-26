require 'git_aware_migrations'
require 'rails'
module GitAwareMigrations
  class Railtie < Rails::Railtie
    railtie_name :git_aware_migrations

    rake_tasks do
      load "tasks/git_aware_migrations.rake"
    end
  end
end
