class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :stripe_token
      t.integer :owner_id

      t.timestamps
    end
  end
end
