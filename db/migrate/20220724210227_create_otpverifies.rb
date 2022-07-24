class CreateOtpverifies < ActiveRecord::Migration[7.0]
  def change
    create_table :otpverifies do |t|
      t.string :otp
      t.string :phonenum

      t.timestamps
    end
  end
end
