require 'active_record'

# Database
ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('test')

# Model
class User < ActiveRecord::Base
end

# Migrations
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:gem_defined_models) { |t| t.string :name; }
    create_table(:users) {|t| t.string :name;}
  end
end
ActiveRecord::Migration.verbose = false
CreateAllTables.up