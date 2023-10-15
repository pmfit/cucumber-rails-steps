# frozen_string_literal: true

require "cucumber"

class FakeWorld
  include CucumberRailsSteps
end

RSpec.describe CucumberRailsSteps do
  let(:world) { FakeWorld.new }

  it "has a version number" do
    expect(CucumberRailsSteps::VERSION).not_to be nil
  end

  describe "#path_method_from" do
    [
      ["users", :users_path],
      ["user", :user_path],
      ["new user", :new_user_path],
      ["edit user", :edit_user_path]
    ].each do |name, expected|
      it "returns #{expected} for #{name}" do
        expect(world.path_method_from(name)).to eq(expected)
      end
    end
  end


    describe "#path_arguments_from" do
      context "the table is nil" do
        it "returns an empty array" do
          expect(world.path_arguments_from(nil)).to eq([])
        end

        context "when column headers have only 1 word" do
          context 'when there is only 1 column' do
            [
              [-1, "-1"],
              [0, "0"],
              [1, "1"],
              [2, "2"],
              ["", ""],
              ["banana", "banana"],
              ["apple", "apple"]
            ].each do |table_value, expected_value|
              it "returns the value (e.g. '#{table_value}')" do
                table = make_table %(
                  | id |
                  | #{table_value}  |
                )

                expect(world.path_arguments_from(table)).to eq([expected_value])
              end
            end
          end

          it "works with multiple arguments" do
            table = make_table %(
                  | grandparent_id | parent_id | id |
                  | 1 | 2 | 3 |
                )

            expect(world.path_arguments_from(table)).to eq(["1", "2", "3"])
          end
        end
      end
    end

  def make_table(raw_table)
    Cucumber::MultilineArgument::DataTable.from(raw_table)
  end
end
