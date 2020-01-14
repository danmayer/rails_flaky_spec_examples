# Rails Flaky Spec Examples Project

flaky: [![CircleCI](https://circleci.com/gh/danmayer/rails_flaky_spec_examples.svg?style=svg)](https://circleci.com/gh/danmayer/rails_flaky_spec_examples) 
stable:  [![GithubCI](https://github.com/danmayer/rails_flaky_spec_examples/workflows/CI/badge.svg)](https://github.com/danmayer/rails_flaky_spec_examples/actions)


This project is supposed to help show flaky test issues by example. You can run the project and see specs that sometimes pass and sometimes fail. 

* each spec file should try to show a single category of flaky spec. It may contain multiple specs with similar examples or have specs that need to be run together to show order dependent issues.
* each spec file nested in a `solved` branch should contain a spec with the same name which is 100% stable, resolving the flaky issue, along with comments on what the issue and problem were.
* if possible, show flakiness in a single spec file vs flakiness requiring the full suite or multiple files

# Getting Started

* `git clone https://github.com/danmayer/rails_flaky_spec_examples`
* `cd rails_flaky_spec_examples`
* `gem install bundler #if you don't have bundler 2.0.X`
* `bundle install`
* `yarn`
* `bundle exec rake db:drop db:create db:migrate`
* `bundle exec rspec --tag solved`  # this should pass meaning you are all setup
* `bundle exec rspec` # this should have a random number of failures

# Understanding Examples

Every example should try to document some notes, at the top of the file.

example docs on flaky spec file:

```ruby
# Classification: Shared State
# Approximate Success Rate: 50%
# Suite Required: false  # does this example stand alone or flake as part of a suite
```

example docs on solved spec file nested in the solved directory:

```ruby
# Classification: Shared State
# Approximate Success Rate: 50%
# Suite Required: false
# Example: very brief description of the bug
#
# Description:
# long description of the flakiness and how it is solved in this solution.
#
# flaky: bundle exec rspec spec/helpers/posts_helper_spec.rb
# failure: bundle exec rspec spec/helpers/posts_helper_spec.rb --seed 52493
# success: bundle exec rspec spec/helpers/posts_helper_spec.rb --seed 52496
```

# Seeing Solutions

The suite is configured by default to run all the specs not tagged `solved`. The full default suite is built with the intention of having a highly unstable, and randomly failing test suite.

Run with `--tag solved` to see specs passes. Each flaky spec should have a paired spec, which has the same intention but aren't flaky and should pass 100% of the time.

* run entire solved suite: `bundle exec rspec --tag solved`
* run individual solved spec: `bundle exec rspec --tag solved spec/helpers/solved/posts_helper_spec.rb`

# Classifications

Each spec should list it's flaky classification(s) from the list below when a new classification example is added please list it below. We encourage multiple examples of the same classification, in different scenarios. For example flaky `timing` classified specs can be very different in unit and system tests.

* Shared State
* Time
* Ordering
* Race Condition
* Randomness
* External Dependency

# Submitting Flaky Examples

We would love additional flaky spec examples if you have solved a bad flaky spec somewhere else try to create a minimal reproducible version of it as a PR for this project.

* Send a PR with two spec files one show how the spec was flaky and another showing it in a "solved" state.
	* one spec file is a flaky spec in the standard spec directory
	* one spec file is a stable spec in a subdirectory of `solved` below the standard spec directory

# TODO

A list of suggested examples, I have yet to add...

* shared state
   * in helpers opposed to class variables a rails.cache (in memory or redis) which persists across specs
   * ^^ alternative or additional to above some tool like flipper based on redis, which persists across specs
* the before(:all) spec never fails  
* add factory_bot example
	* We could solve with factorybot sequences title1, title2, title3
	* could be solved this way as an alternative spec/models/post_example_e_spec.rb
* Timing
	* timezone specific example (vs DST)
	* new year
	* leap year 
* avoid exact ordering, match_array matcher instead of eq([...]). or eq vs include?
* another hard coded id example, `expect { Post.find(42) }.to raise_error(ActiveRecord::RecordNotFound)`
* capybara
   * ajax request race conditions
   * with external network API request
   * add how to precompile assets so there isn't a race on very first spec that needs assets
* infrastructure error like redis or postgres hasn't started in time for the spec suite
    * perhaps this one is to much of a CI or machine setup timing issue vs flaky tests?  
* class munging definine the same fake test class in two different specs, that would fail when run in wrong order
* make network call modlel spec more clear to be a network spec
    * switch the it to be on the specific network call method not the one before it  

# Interesting Seeds

These can be helpful in terms of examples and understanding what is happening... Technically if absolutely everything goes right, the flaky spec suite could pass...

* `bundle exec rspec --seed 23455 spec/models/` -> a passing run

# Resources

There are a number of good related posts and projects that are also good follow up reading on flaky specs.

* some specs are modified examples from [Why RSpec Tests Fail (and How To Fix Them)](https://medium.com/better-programming/why-rspec-tests-fail-and-how-to-fix-them-402f1c7dce16)
* some specs are modified examples from [tests that sometimes fail](https://samsaffron.com/archive/2019/05/15/tests-that-sometimes-fail)
* make it easier to debug flaky tests, [5-ways to improve flaky test debugging](https://building.buildkite.com/5-ways-weve-improved-flakey-test-debugging-4b3cfb9f27c8)
* test-smells, [examples of bad JS and Ruby test patterns](https://github.com/testdouble/test-smells)
* * [Flaky Test Detection](https://buildpulse.io/), help detect and find tests causing flakiness
* [list of flaky test practices to avoid](https://github.com/evilmartians/terraforming-rails/blob/master/guides/flaky.md)
* [fixing flaky tests like a detective](https://sonja.codes/fixing-flaky-tests-like-a-detective)
* [eliminating flaky ruby tests](https://engineering.gusto.com/eliminating-flaky-ruby-tests/)
