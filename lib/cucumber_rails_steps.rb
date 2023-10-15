# frozen_string_literal: true

require_relative "version"

module CucumberRailsSteps
  class Error < StandardError; end

  def path_from(name, table = nil)
    send(path_method_from(name), *path_arguments_from(table))
  end

  def path_method_from(name)
    name_in_snake_case = name.downcase.gsub(/\s/, "_")

    "#{name_in_snake_case}_path".to_sym
  end

  def path_arguments_from(table)
    return [] if !table

    objects = []

    table.headers.each_with_index do |header, index|
      this_header = table.headers[index]
      class_attribute = this_header.split(" ")
      if class_attribute.length == 1
        value = table.rows.first[index]
        objects << value
        next
      end
      class_name = class_attribute.first
      attribute = class_attribute.last
      klass = Object.const_get(class_name)
      value = table.rows.first[index]
      entity = if attribute == "id"
                 value
               else
                 klass.find_by({attribute => value})
               end
      raise "Couldn't find #{class_name} with #{attribute} #{value}" unless entity
      objects << entity
    end

    objects
  end
end
