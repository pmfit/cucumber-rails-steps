# frozen_string_literal: true

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
end
