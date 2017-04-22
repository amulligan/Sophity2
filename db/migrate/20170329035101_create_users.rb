class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :job_title
      t.string :company
      t.string :phone
      t.boolean :send_notification
      t.boolean :report_requested
      t.timestamps null: false
    end
  end
end
