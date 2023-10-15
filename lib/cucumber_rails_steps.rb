# frozen_string_literal: true

require_relative "version"

module CucumberRailsSteps
  class Error < StandardError; end

  class PathMethod
    def resolve(name)
      name_in_snake_case = name.downcase.gsub(/\s/, '_')

      "#{name_in_snake_case}_path".to_sym
    end
  end

  class Arguments
    def resolve(table)
      return [] if !table

      [1]
    end
  end
end
