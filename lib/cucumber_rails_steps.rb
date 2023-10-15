# frozen_string_literal: true

require_relative "version"

module CucumberRailsSteps
  class Error < StandardError; end

  class PathResolver
    def resolve_method(name)
      "#{name}_path".to_sym
    end
  end
end
