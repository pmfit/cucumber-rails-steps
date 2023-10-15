# frozen_string_literal: true

require_relative "version"

module CucumberRailsSteps
  class Error < StandardError; end

  class PathResolver
    def resolve_method(_name)
      :users_path
    end
  end
end
