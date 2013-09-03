class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :domain
      t.integer :subscription_id

      t.timestamps
    end
  end
end
