class CreateUserrecords < ActiveRecord::Migration[7.0]
  def change
    create_table :userrecords do |t|
      t.string :phone

      t.timestamps
    end
  end
end
