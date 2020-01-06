# Rails Flaky Spec Examples Project

This project is supposed to help show flaky test issues by example. You can run the project and see specs which sometimes pass and sometimes fail. 

* each spec file should try to show a single category of flaky spec. It may contain multiple specs with similar examples or have specs that need to be run together to show order dependant issues.
* each spec file on the `solutions` branch should contain the spec in a 100% stable manner resolving the flaky issue, along with comments on what the issue and problem was.

# Getting Started

* `git clone`
* `bundle install`
* `bundle exec rake db:drop db:create db:migrate`

# Seeing Solutions

The master branch is built with the intention of having a highly unstable, but randomly failing test suite. Switch to the `solutions` branch to see specs which have the same intention but aren't flaky and should pass 100% of the time.

# Submitting Flaky Examples

We would love additional flaky spec examples, if you have solved a bad flaky spec somewhere else try to create a minimal reproducable version of it as a PR for this project.

* Send two PRs one show how the spec was flaky and another showing it in a "solved" state.
	* send a PR which includes a flaky spec to the master branch
	* send a PR which includes a stable spec to the solutions branch
	* please cross link the PRs

# Resources

* some specs are modified examples from [Why RSpec Tests Fail (and How To Fix Them)](https://medium.com/better-programming/why-rspec-tests-fail-and-how-to-fix-them-402f1c7dce16)
* some specs are modified examples from [tests that sometimes fail](https://samsaffron.com/archive/2019/05/15/tests-that-sometimes-fail)