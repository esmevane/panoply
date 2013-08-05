class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :sender_id
      t.integer :availability_id

      t.timestamps
    end
  end
end
