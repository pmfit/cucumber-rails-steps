# frozen_string_literal: true

require "cucumber"

class FakeWorld
  include CucumberRailsSteps
end

class FakeModel
  def self.find_by()
    FakeModel.new
  end
end

RSpec.describe CucumberRailsSteps do
  let(:world) { FakeWorld.new }

  it "has a version number" do
    expect(CucumberRailsSteps::VERSION).not_to be nil
  end

  describe "#path_from" do
    it "users index" do
      expect(world).to receive(:users_path)

      world.path_from("users")
    end

    it "show user" do
      expect(world).to receive(:user_path).with("1")

      table = make_table %(
        | id |
        | 1  |
      )

      world.path_from("user", table)
    end

    it "edit user" do
      expect(world).to receive(:edit_user_path).with("1")

      table = make_table %(
        | id |
        | 1  |
      )

      world.path_from("edit user", table)
    end

    it "new user" do
      expect(world).to receive(:new_user_path).with("1")

      table = make_table %(
        | id |
        | 1  |
      )

      world.path_from("new user", table)
    end

    context "nested resources" do
      it "user posts index" do
        expect(world).to receive(:user_posts_path).with("1")

        table = make_table %(
          | user_id |
          | 1  |
        )

        world.path_from("user posts", table)
      end

      it "show user post" do
        expect(world).to receive(:user_post_path).with("1", "2")

        table = make_table %(
          | user_id | id |
          | 1  | 2 |
        )

        world.path_from("user post", table)
      end

      it "edit user post" do
        expect(world).to receive(:edit_user_post_path).with("1", "2")

        table = make_table %(
          | user_id | id |
          | 1  | 2 |
        )

        world.path_from("edit user post", table)
      end

      it "new user post" do
        expect(world).to receive(:new_user_post_path).with("1", "2")

        table = make_table %(
          | user_id | id |
          | 1  | 2 |
        )

        world.path_from("new user post", table)
      end
    end
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
    end

    context "when column headers have only 1 word" do
      context "when there is only 1 column" do
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

  def make_table(raw_table)
    Cucumber::MultilineArgument::DataTable.from(raw_table)
  end
end
