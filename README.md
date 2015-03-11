# waylon [![Build Status](https://travis-ci.org/rji/puppet-waylon.svg?branch=master)](https://travis-ci.org/rji/puppet-waylon)
A Puppet module to deploy [Waylon][1] instances.


## Overview
This is a Puppet module to manage all aspects of deploying an instance of
Waylon, an application that displays the status of your Jenkins builds.

This module will install and manage Ruby (via rbenv), Waylon (via Rubygems),
Memcached, and Nginx, all on a single host.


## Compatibility
This module was developed to work with Debian 7 "Wheezy" running Puppet 3.x.
We plan to add support for additional operating systems in the future.


## Usage
Simply include the `waylon` class in your Puppet manifests, like so:

```puppet
include waylon
```

You can also customize the deployment, to an extent:

```puppet
class { 'waylon':
  ruby_version   => '2.1.5',
  waylon_version => '2.1.0,
}
```

Note that Waylon requires Ruby 2.1.0 or newer.


## Development
This module was developed using Ruby 2.1.x and Puppet 3.x. After running
`bundle install`, there are a series of Rake tasks that can be executed to
validate syntax, perform linting, and execute tests:

```
$ bundle exec rake -T
rake beaker            # Run beaker acceptance tests
rake beaker_nodes      # List available beaker nodesets
rake build             # Build puppet module package
rake clean             # Clean a built module package
rake coverage          # Generate code coverage information
rake help              # Display the list of available rake tasks
rake lint              # Check puppet manifests with puppet-lint / Run pupp...
rake spec              # Run spec tests in a clean fixtures directory
rake spec_clean        # Clean up the fixtures directory
rake spec_prep         # Create the fixtures directory
rake spec_standalone   # Run spec tests on an existing fixtures directory
rake syntax            # Syntax check Puppet manifests and templates
rake syntax:hiera      # Syntax check Hiera config files
rake syntax:manifests  # Syntax check Puppet manifests
rake syntax:templates  # Syntax check Puppet templates
rake validate          # Check syntax of Ruby files and call :syntax / Vali...
```

We use Travis CI to run syntax validation, linting, and spec tests, in that
order.

For more information on contributing to rji-waylon, please see the
[CONTRIBUTING][2] doc in the root of this repo.

[1]: https://github.com/rji/waylon
[2]: CONTRIBUTING.md
