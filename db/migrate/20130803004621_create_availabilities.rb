class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.integer :provider_id
      t.datetime :starts_on
      t.datetime :ends_on

      t.timestamps
    end
  end
end
