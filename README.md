# CucumberRailsSteps

> ## WARNING: Very Unstable
> This Gem is still in early development and not yet ready for general use.
> 
> The API and even the name of the gem are likely to change without notice.

This gem provides some useful helpers and step definitions for testing Rails applications with Cucumber.


## Installation

Add this line to your application's Gemfile:

```ruby
group :test do
  gem "cucumber-rails-steps", github: 'pmfit/cucumber-rails-steps', branch: 'main'
end
```

And then somewhere in your Cucumber setup do

```ruby
require 'cucumber_rails_steps'

World(CucumberRailsSteps)
```

## Usage

### Setting the current page

#### Paths without arguments 

Create a step definition like this:

```ruby
When("I'm on the {string} page") do |page_name|
  visit_path_for(page_name)
end
```

Now you can visit any page by normal-human readable name.

**Example 1: Users Index**
```gherkin
When I'm on the "users" page
```

**Example 2: New Users**
```gherkin
When I'm on the "new user" page
```

#### Paths with arguments


Create a step definition like this:
```ruby
When("I'm on the {string} page for") do |page_name, table|
  visit_path_for(page_name, table)
end
```

This let's you navigate to a specific record's page without having to know the database id of the record.

Instead, you can lookup the record by any attribute you want.

**Example 1: Show User**
```gherkin
When I'm on the "user" page for
  | User email | 
  | test@example.com |
```
It will lookup the user by email and visit the path for that user. 

**Example 2: Edit User**
```gherkin
When I'm on the "edit user" page for
  | User email |
  | test@example.com |
```

**Example 3: User's Post**
```gherkin
When I'm on the "user" page for
  | User email | Post title |
  | test@example.com | Hello World |
```
 The above is equivalent ot 

```ruby
user = User.find_by(email: "test@example.com")
post = Post.find_by(title: "Hello World")

visit(user_post_path(user, post))
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cucumber-rails-steps. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/cucumber-rails-steps/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CucumberRailsSteps project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/cucumber-rails-steps/blob/main/CODE_OF_CONDUCT.md).
