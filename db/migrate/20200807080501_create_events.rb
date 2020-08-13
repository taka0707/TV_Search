class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :memo
      t.datetime :start_time, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
