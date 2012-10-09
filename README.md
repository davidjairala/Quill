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

At this point it's pretty similar to the [Kaminari gem](https://github.com/amatsuda/kaminari), on which this project is based and inspired by.

    User.qpage(1)
    User.qpage(2)
    User.qpage(1).next_page?
    User.qpage(2).previous_page?

You can set up the following configuration options:

    default_per_page  - number of items per page (20 by default)

## TODO

* View generators for the pagination fragments.
* Cache all the things!

## Bugs or ideas?

Hit me up here or by email ([davidjairala@gmail.com](davidjairala@gmail.com)) or in my [blog](http://davemode.com/).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
