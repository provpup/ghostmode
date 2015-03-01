class AddGeocoderSupport < ActiveRecord::Migration
  def change
    add_index :gps_points, [:latitude, :longitude]
  end
end
