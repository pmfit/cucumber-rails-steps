# frozen_string_literal: true

require_relative "version"

module CucumberRailsSteps
  class Error < StandardError; end

  class PathResolver
    def resolve_method(name)
      name_in_snake_case = name.downcase.gsub(/\s/, '_')

      "#{name_in_snake_case}_path".to_sym
    end
  end
end
