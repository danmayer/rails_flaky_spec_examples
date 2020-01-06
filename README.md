# Rails Flaky Spec Examples Project

This project is supposed to help show flaky test issues by example. You can run the project and see specs which sometimes pass and sometimes fail. 

* each spec file should try to show a single category of flaky spec. It may contain multiple specs with similar examples or have specs that need to be run together to show order dependant issues.
* each spec file on the `solutions` branch should contain the spec in a 100% stable manner resolving the flaky issue, along with comments on what the issue and problem was.
* if possible, show flakiness in a single spec file vs flakiness requiring the full suite or multiple files

# Understanding Examples

Every example should try to document some notes, at the top of the file.

example docs on flaky spec file on master branch:

```ruby
# Classification: Shared State
# Approximate Success Rate: 50%
# Suite Required: false
```

example docs on solved spec file on solutions branch:

```
# Classification: Shared State
# Approximate Success Rate: 50%
# Example: Shared Class Variable State, in file test order dependency
#
# Description:
# Specs in this file have access to a helper object that includes
# a class based variable counter. The tests when run will pass or fail depending
# on the order they are run. In this example it should fail 50% of the time.
#
# flaky: bundle exec rspec spec/helpers/posts_helper_spec.rb
# failure: bundle exec rspec spec/helpers/posts_helper_spec.rb --seed 52493
# success: bundle exec rspec spec/helpers/posts_helper_spec.rb --seed 52496
```

### Notes on Example Docs

Note all specs will be able to have a estimated success rate. Also, not all example will be able to provide `flaky`, `failure`, and `success` examples.

# Getting Started

* `git clone`
* `bundle install`
* `bundle exec rake db:drop db:create db:migrate`

# Seeing Solutions

The master branch is built with the intention of having a highly unstable, but randomly failing test suite. Switch to the `solutions` branch to see specs which have the same intention but aren't flaky and should pass 100% of the time.

# Classifications

Each spec should list it's flaky classification(s) from the list below, when a new classification example is added please list it below. We encourage multiple examples of the same classification, in different scenarios. For example flaky `timing` classified specs can be very different in unit and system tests.

* Shared State
* Timing
* Order Dependency

# Submitting Flaky Examples

We would love additional flaky spec examples, if you have solved a bad flaky spec somewhere else try to create a minimal reproducable version of it as a PR for this project.

* Send two PRs one show how the spec was flaky and another showing it in a "solved" state.
	* send a PR which includes a flaky spec to the master branch
	* send a PR which includes a stable spec to the solutions branch
	* please cross link the PRs

# Resources

* some specs are modified examples from [Why RSpec Tests Fail (and How To Fix Them)](https://medium.com/better-programming/why-rspec-tests-fail-and-how-to-fix-them-402f1c7dce16)
* some specs are modified examples from [tests that sometimes fail](https://samsaffron.com/archive/2019/05/15/tests-that-sometimes-fail)
* make it easier to debug flaky tests, [5-ways to improve flaky test debugging](https://building.buildkite.com/5-ways-weve-improved-flakey-test-debugging-4b3cfb9f27c8)