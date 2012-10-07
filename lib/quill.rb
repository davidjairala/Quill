module Quill
end

# load Rails/Railtie
require 'rails'

$stderr.puts <<-EOC if !defined?(Rails)
warning: no Rails detected.

Your Gemfile might not be configured properly.
Rails:
    gem 'quill'
EOC

require 'quill/components'