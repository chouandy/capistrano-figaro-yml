include Capistrano::FigaroYml::Paths
include Capistrano::FigaroYml::Helpers

namespace :load do task :defaults do
    set :figaro_yml_local_path, "config/application.yml"
    set :figaro_yml_remote_path, "config/application.yml"
    set :figaro_yml_env, -> { fetch(:rails_env) || fetch(:stage) }
  end
end

namespace :figaro_yml do

  task :check_figaro_file_exists do
    next if File.exists?(figaro_yml_local_path)
    check_figaro_file_exists_error
    exit 1
  end

  task :check_git_tracking do
    next unless system("git ls-files #{fetch(:figaro_yml_local_path)} --error-unmatch >/dev/null 2>&1")
    check_git_tracking_error
    exit 1
  end

  task :check_config_present do
    next unless local_figaro_yml(figaro_yml_env).nil?
    check_config_present_error
    exit 1
  end

  desc "figaro `application.yml` file checks"
  task :check do
    invoke "figaro_yml:check_figaro_file_exists"
    invoke "figaro_yml:check_git_tracking"
    invoke "figaro_yml:check_config_present"
  end

  desc "Setup figaro `application.yml` file on the server(s)"
  task setup: [:check] do
    content = figaro_yml_content
    on release_roles :all do
      execute :mkdir, "-pv", File.dirname(figaro_yml_remote_path)
      upload! StringIO.new(content), figaro_yml_remote_path
    end
  end

  # Update `linked_files` after the deploy starts so that users'
  # `figaro_yml_remote_path` override is respected.
  task :figaro_yml_symlink do
    set :linked_files, fetch(:linked_files, []).push(fetch(:figaro_yml_remote_path))
  end
  after "deploy:started", "figaro_yml:figaro_yml_symlink"

end

desc "Server setup tasks"
task :setup do
  invoke "figaro_yml:setup"
end
