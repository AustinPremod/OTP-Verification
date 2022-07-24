class CreateOtprequests < ActiveRecord::Migration[7.0]
  def change
    create_table :otprequests do |t|
      t.string :phonenumber

      t.timestamps
    end
  end
end
