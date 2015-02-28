class CreateInitialTables < ActiveRecord::Migration
  def change
    create_table :users do |table|
      table.string :username
      table.string :password
      table.timestamps null: false
    end

    create_table :routes do |table|
      table.string :name
      table.timestamps null: false
    end

    create_table :runs do |table|
      table.references :user
      table.references :route
    end

    create_table :gps_points do |table|
      # Need to setup polymorphic association
      table.references :pointable, polymorphic: true

      table.float :longitude
      table.float :latitude
      table.timestamp :gps_timestamp
    end
  end
end
