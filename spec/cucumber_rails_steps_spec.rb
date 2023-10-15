# frozen_string_literal: true
require "cucumber"

RSpec.describe CucumberRailsSteps do
  it "has a version number" do
    expect(CucumberRailsSteps::VERSION).not_to be nil
  end

  describe CucumberRailsSteps::PathMethod do
    let(:path_method) { CucumberRailsSteps::PathMethod.new }

    describe '#resolve' do
      [
        # ['path name', :expected_method_name],
        ['users', :users_path],
        ['user', :user_path],
        ['new user', :new_user_path],
        ['edit user', :edit_user_path],
      ].each  do |name, expected|
        it "returns #{expected} for #{name}" do
          expect(path_method.resolve(name)).to eq(expected)
        end
      end
    end
  end

  describe CucumberRailsSteps::Arguments do
    let(:arguments) { CucumberRailsSteps::Arguments.new }

    describe '#resolve' do
      context 'the table is nil' do
        it 'returns an empty array' do
          expect(arguments.resolve(nil)).to eq([])
        end

        it 'returns the column if the column header has 1 word' do
          table = make_table %{
            | id |
            | 1  |
          }

          expect(arguments.resolve(table)).to eq([1])
        end
      end
    end
  end

  def make_table(raw_table)
    Cucumber::MultilineArgument::DataTable.from(raw_table)
  end
end
