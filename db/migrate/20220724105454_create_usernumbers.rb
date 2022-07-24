class CreateUsernumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :usernumbers do |t|
      t.string :phone
      t.string :otp
      t.string :counter
      t.string :otpcounter
      t.timestamps
    end
  end
end
