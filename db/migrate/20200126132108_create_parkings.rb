class CreateParkings < ActiveRecord::Migration[6.0]
  def change
    create_table :parkings do |t|
      t.string :plate
      t.datetime :checkin
      t.datetime :checkout
      t.datetime :payment_time
      t.boolean :paid
      t.float :paid_value
      t.boolean :left

      t.timestamps
    end
  end
end
