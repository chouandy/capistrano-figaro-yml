require "pathname"

module Capistrano
  module FigaroYml
    module Paths

      def figaro_yml_local_path
        Pathname.new fetch(:figaro_yml_local_path)
      end

      def figaro_yml_remote_path
        shared_path.join fetch(:figaro_yml_remote_path)
      end

    end
  end
end
