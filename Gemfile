source 'https://rubygems.org'
# ruby '2.2.1'

gem 'rails',                   '~> 4.2.0'

# Uploading
gem 'carrierwave',             '~> 0.10.0'  # For image upload.
gem 'mini_magick',             '~> 3.8.0'   # For image resizing.
gem 'fog',                     '~> 1.23.0'  # For cloud storage.
# Styling
gem 'will_paginate',           '~> 3.0.7'   # For pagination.
gem 'bootstrap-will_paginate', '~> 0.0.10'  # Converts pagination to bootstrap style.
gem 'bootstrap-sass',          '~> 3.2.0.0' # Converts Less to Sass.
gem 'bootswatch-rails',        '~> 3.2.4'   # For custom bootswatch themes.
gem 'font-awesome-rails',      '~> 4.3.0.0' # For icons.
# Views
gem 'haml-rails',              '~> 0.9'     # For HAML.
gem 'redcarpet',               '~> 3.2.2'   # For Markdown.
gem 'ransack',                 '~> 1.6.6'   # For searching and sorting.
# Security
gem 'bcrypt',                  '~> 3.1.7'   # For password digest.
# Rails
gem 'sass-rails',              '~> 5.0.1'
gem 'uglifier',                '~> 2.5.3'
gem 'coffee-rails',            '~> 4.1.0'
gem 'jquery-rails',            '~> 4.0.3'
gem 'jquery-turbolinks',       '~> 0.2.1'   # For jQuery to work with turbolinks.
gem 'turbolinks',              '~> 2.3.0'
gem 'jbuilder',                '~> 2.2.3'
gem 'sdoc',                    '~> 0.4.0', group: :doc

group :development, :test do
  gem 'sqlite3',           '~> 1.3.9'
  gem 'byebug',            '~> 3.4.0'  # For the byebug prompt in the terminal.
  gem 'better_errors',     '~> 2.1.1'  # For a better error page on the browser.
  gem 'binding_of_caller', '~> 0.7.2'  # For the binding of a method's caller.
  gem 'annotate',          '~> 2.6.8'  # Annotates models.
  gem 'rails-erd',         '~> 1.3.1'  # Generates an entity-relationship diagram for Rails models.
  gem 'awesome_print',     '~> 1.6.1'  # Pretty-prints Ruby objects.
  gem 'quiet_assets',      '~> 1.1.0'  # Turns off Rails asset pipeline log.
  gem 'faker',             '~> 1.4.2'  # Generates sample users.
  gem 'guard-livereload',  '~> 2.4', require: false  # Automatically reload the browser when 'view' files are modified.
  gem 'spring',            '~> 1.1.3'
end

group :test do
  gem 'minitest-reporters', '~> 1.0.5'  # Gets the minitest to show red and green.
  gem 'mini_backtrace',     '~> 0.1.3'  # Filters the backtrace to eliminate unwanted lines.
  gem 'guard-minitest',     '~> 2.3.1'  # Automates the running of the tests.
end

group :production do
  gem 'pg',             '~> 0.17.1'  # For postgres
  gem 'rails_12factor', '~> 0.0.2'   # For postgres
  gem 'puma',           '~> 2.11.1'  # A production webserver
end
