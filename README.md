# RxNav

[![Gem Version](http://img.shields.io/gem/v/rx_nav.svg?style=flat-square)](https://rubygems.org/gems/rx_nav) [![Dependency Status](http://img.shields.io/gemnasium/jbender/rx_nav_ruby.svg?style=flat-square)](https://gemnasium.com/jbender/rx_nav_ruby)
 [![Code Climate](http://img.shields.io/codeclimate/github/jbender/rx_nav_ruby.svg?style=flat-square)](https://codeclimate.com/github/jbender/rx_nav_ruby) [![Test Coverage](https://img.shields.io/codeclimate/coverage/github/jbender/rx_nav_ruby.svg?style=flat-square)](https://codeclimate.com/github/jbender/rx_nav_ruby)
 [ ![Codeship Status for jbender/rx_nav_ruby](https://img.shields.io/codeship/e1dd97e0-8d48-0132-a9a4-5691319bff63.svg?style=flat-square)](https://codeship.com/projects/60640)

This gem makes it easier to work with the RxNav REST APIs, as enumerated on [this page](http://rxnav.nlm.nih.gov/APIsOverview.html).

Currently, there are wrappers for the [RxNorm](http://rxnav.nlm.nih.gov/RxNormAPIREST.html), [NDF-RT](http://rxnav.nlm.nih.gov/NdfrtAPIREST.html), and [RxTerms](http://rxnav.nlm.nih.gov/RxTermsAPIREST.html) APIs. Not all end points are covered, so be sure to check out the code to make sure the endpoint you're looking for is available in the wrapper. If it isn't, please feel free to fork, add it, and send a pull request.

## Installation

Add this line to your application's Gemfile:

    gem 'rx_nav'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rx_nav

## Usage

Each service has it's own class, which have the class methods enumerated below. When appropriate, these methods will return `Concept`s, which are further queryable to retrieve more information about a specific drug. **Question marks indicate optional parameters.**

Please note that according to the [NLM Terms of Service](http://rxnav.nlm.nih.gov/TermOfService.html), you can will only be able to make **20 requests/second/IP**, so keep that in mind when implementing this project.

### [NDF-RT (Class named NDFRT)](https://github.com/jbender/rx_nav_ruby/blob/master/lib/rx_nav/ndfrt.rb)

  * all_records_by_kind
  * get_info
  * find_by_name(name, kind?)
  * find_by_id(type, id)
  * find_by({type: x, id: y} OR {name: x, kind: y})
  * possible_roles
  * possible_properties
  * possible_kinds
  * possible_types
  * possible_associations
  * possible_options_for(type)
  * api_version

### [RxNorm](https://github.com/jbender/rx_nav_ruby/blob/master/lib/rx_nav/rx_norm.rb)

  * search_by_name(name, options?)
  * find_rxcui_by_id(type, id)
  * find_rxcui_by_name(name)
  * find_drugs_by_name(name)
  * spelling_suggestions(name)
  * status(id)
  * properties(id)
  * quantity(id)
  * strength(id)

### [RxTerms](https://github.com/jbender/rx_nav_ruby/blob/master/lib/rx_nav/rx_terms.rb)

  * all_concepts
  * all_info(id)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
