require 'rubygems'
require 'bundler/setup'

require 'active_support/all'

require 'active_record'
require 'geocoder'
require 'rspec/collection_matchers'

require 'factory_girl'
require 'faker'
require 'database_cleaner'
require 'dotenv'
Dotenv.load

require_relative 'app/models/user'
require_relative 'app/models/gpspoint'
require_relative 'app/models/route'
require_relative 'app/models/run'
require_relative 'app/timejudge'
require_relative 'factories/spec/user'
require_relative 'factories/spec/gpspoint'
require_relative 'factories/spec/route'

db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

ActiveRecord::Base.establish_connection(
  adapter:  db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  host:     db.host,
  username: db.user,
  password: db.password,
  database: db.path[1..-1],
  encoding: 'utf8'
)

# Recreate the database
ActiveRecord::Migration.suppress_messages do
  require './db/schema.rb'
end

RSpec.configure do |config|

   #config.use_transactional_examples = false
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.mock_with(:rspec) do |mocks|
    # This option should be set when all dependencies are being loaded
    # before a spec run, as is the case in a typical spec helper. It will
    # cause any verifying double instantiation for a class that does not
    # exist to raise, protecting against incorrectly spelt names.
    mocks.verify_doubled_constant_names = true
  end
end

I18n.enforce_available_locales = false
