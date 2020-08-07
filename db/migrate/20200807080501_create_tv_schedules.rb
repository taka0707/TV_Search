class CreateTvSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :tv_schedules do |t|
      t.string :title, null: false
      t.string :channel, null: false
      t.datetime :start_time, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
