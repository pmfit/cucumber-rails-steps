# frozen_string_literal: true

RSpec.describe CucumberRailsSteps do
  it "has a version number" do
    expect(CucumberRailsSteps::VERSION).not_to be nil
  end

  describe CucumberRailsSteps::PathResolver do
    let(:resolver) { CucumberRailsSteps::PathResolver.new }
    describe '#resolve_method' do
      [
        ['users', :users_path],
      ].each  do |name, expected|
        it "returns #{expected} for #{name}" do
          expect(resolver.resolve_method(name)).to eq(expected)
        end
      end
    end
  end
end
