# Contributing to Waylon
Third-party patches are essential for keeping the Waylon Puppet module great.
We want to keep it as easy as possible to contribute changes that get things
working in your environment. There are a few guidelines we need contributors to
follow so that we can have a chance of staying on top of things.

## Getting Started
* Make sure you have a [GitHub account](https://github.com/join).
* Submit a ticket for your issue, assuming one does not already exist.
  * Clearly describe the issue, and any steps needed to reproduce it.
  * The version or SHA of the software you're using.
* Fork the repository on GitHub.

## Making Changes
* Create a topic branch from where you want to base your work.
  * Work should typically be based on the `master` branch.
  * To quickly create a topic branch based on master:
  `git checkout -b my-contribution master`.
    * Except for trivial changes, please avoid working directly on the `master`
    branch.
* Make commits of logical units.

### Trivial Changes
For trivial changes to comments and documentation, it's not always necessary to
create a new ticket or topic branch. Please, use your best judgement.

### Style Guidelines
Before submitting your pull request, please consider the following:
  * Check for unnecessary whitespace with `git diff --check`. All tabs should
  be expanded to spaces; hard tabs will not be accepted.
  * Please keep line length to around 79-80 characters. We understand that
  this isn't always practical, just use your best judgement.
  * Include comments where appropriate.
  * No additional copyright statements or licenses.
  * Make sure your commit message is in the proper format:

  ```
  Make the example in CONTRIBUTING imperative and concrete

  Without this patch applied, the contributor is left to
  imagine what the commit message should look like based
  on a description rather than an example.

  The first line is a real-life statement, potentially with
  a ticket number from the issue tracker. The body describes
  the behavior without the patch, why it's a problem, and
  how the patch fixes the problem when applied.
  ```

When in doubt, consult the [Puppet Language Style Guide](https://docs.puppetlabs.com/guides/style_guide.html).

## Submitting Changes
  * Push your changes to a topic branch in your fork of the repository.
  * Submit a pull request to the Waylon module's main GitHub repository,
  [rji/puppet-waylon](https://github.com/rji/puppet-waylon).
  * Update any outstanding tickets (if applicable) to mention that you have
  submitted code, and provide a link / reference to the pull request.

# Additional Resources
  * [Issue tracker (GitHub)](https://github.com/rji/puppet-waylon/issues)
  * [General GitHub documentation](https://help.github.com)
  * [GitHub pull request documentation](https://help.github.com/articles/using-pull-requests)

