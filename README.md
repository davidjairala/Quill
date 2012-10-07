# Quill

Fast and simple object pagination for Rails.

## Installation

Add this line to your application's Gemfile:

    gem 'quill'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quill

## Usage

At this point it's pretty much a drop-in replacement for the [Kaminari gem](https://github.com/amatsuda/kaminari), on which this project is based and inspired by.

    User.page(1)
    User.page(2).per(10)

You can set up the following configuration options:

    default_per_page  - number of items per page (20 by default)
    page_method_name  - page method name (page by defualt)
    param_name        - param name (page by default)
    cache_page        - determines if Quill will cache page and count results (true by default)
    cache_expires_in  - cache time to live

## TODO

* Read the cache instead of computing everytime
* Caching for the per method is not ready yet, need to figure it out still.
* View generators for the pagination fragments.

## Bugs or ideas?

Hit me up here or by email ([davidjairala@gmail.com](davidjairala@gmail.com)) or in my [blog](http://davemode.com/).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
