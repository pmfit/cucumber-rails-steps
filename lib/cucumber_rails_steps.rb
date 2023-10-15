# frozen_string_literal: true

require_relative "version"

module CucumberRailsSteps
  class Error < StandardError; end

  def path_method_from(name)
    name_in_snake_case = name.downcase.gsub(/\s/, "_")

    "#{name_in_snake_case}_path".to_sym
  end

  def path_arguments_from(table)
    Arguments.new.resolve(table)
  end

  class Arguments
    def resolve(table)
      return [] if !table

      arguments = []

      table.headers.each_with_index do |_header, index|
        arguments << table.rows.first[index]
      end

      arguments
    end
  end
end
