# frozen_string_literal: true

RSpec.describe CucumberRailsSteps do
  it "has a version number" do
    expect(CucumberRailsSteps::VERSION).not_to be nil
  end

  describe CucumberRailsSteps::PathResolver do
    let(:resolver) { CucumberRailsSteps::PathResolver.new }
    describe '#resolve_method' do
      it 'returns the correct method for a given name' do
        name = "users"

        expect(resolver.resolve_method(name)).to eq(:users_path)
      end
    end
  end
end
