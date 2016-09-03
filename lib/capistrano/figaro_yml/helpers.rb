require "yaml"

module Capistrano
  module FigaroYml
    module Helpers

      def local_figaro_yml(env)
        @local_figaro_yml ||= YAML.load(ERB.new(File.read(figaro_yml_local_path)).result)
        local_figaro = {}
        deployment_env = fetch(:rails_env, env).to_s

        @local_figaro_yml.each do |key, value|
          if key == env
            local_figaro[deployment_env] = @local_figaro_yml[key]
          elsif !value.is_a?(Hash)
            local_figaro[key] = @local_figaro_yml[key]
          end
        end

        local_figaro
      end

      def figaro_yml_env
        fetch(:figaro_yml_env).to_s
      end

      def figaro_yml_content
        local_figaro_yml(figaro_yml_env).to_yaml
      end

      # error helpers

      def check_git_tracking_error
        puts
        puts "Error - please remove '#{fetch(:figaro_yml_local_path)}' from git:"
        puts
        puts "    $ git rm --cached #{fetch(:figaro_yml_local_path)}"
        puts
        puts "and gitignore it:"
        puts
        puts "    $ echo '#{fetch(:figaro_yml_local_path)}' >> .gitignore"
        puts
      end

      def check_config_present_error
        puts
        puts "Error - '#{figaro_yml_env}' config not present in '#{fetch(:figaro_yml_local_path)}'."
        puts "Please populate it."
        puts
      end

      def check_figaro_file_exists_error
        puts
        puts "Error - '#{fetch(:figaro_yml_local_path)}' file does not exists, and it's required."
        puts
      end

    end
  end
end
