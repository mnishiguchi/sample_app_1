source 'https://rubygems.org'
# ruby '2.2.1'

gem 'rails',                   '4.2.0'
gem 'bcrypt',                  '3.1.7'    # for password digest
gem 'faker',                   '1.4.2'
gem 'carrierwave',             '0.10.0'
gem 'mini_magick',             '3.8.0'
gem 'fog',                     '1.23.0'
gem 'will_paginate',           '3.0.7'
gem 'bootstrap-will_paginate', '0.0.10'
gem 'bootstrap-sass',          '3.2.0.0'  # converts Less to Sass
gem 'sass-rails',              '5.0.1'
gem 'uglifier',                '2.5.3'
gem 'coffee-rails',            '4.1.0'
gem 'jquery-rails',            '4.0.3'
gem 'haml-rails',              '0.9'      # for HAML
gem 'redcarpet',               '3.2.2'    # for HAML
gem 'turbolinks',              '2.3.0'
gem 'jbuilder',                '2.2.3'
gem 'sdoc',                    '0.4.0', group: :doc

group :development, :test do
  gem 'sqlite3',     '1.3.9'
  gem 'byebug',      '3.4.0'              # for debugger and byebug prompt
  gem 'web-console', '2.0.0.beta3'
  gem 'spring',      '1.1.3'
end

group :test do
  # get the default Rails tests to show red and green
  gem 'minitest-reporters', '1.0.5'
  # filter the backtrace to eliminate unwanted lines
  gem 'mini_backtrace',     '0.1.3'
  # automate the running of the tests
  gem 'guard-minitest',     '2.3.1'
end

group :production do
  gem 'pg',             '0.17.1'  # for postgres
  gem 'rails_12factor', '0.0.2'   # for postgres
  gem 'puma',           '2.11.1'  # production webserver
end
