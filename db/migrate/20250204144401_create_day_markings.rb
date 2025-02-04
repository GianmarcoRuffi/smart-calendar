class CreateDayMarkings < ActiveRecord::Migration[7.2]
  def change
    create_table :day_markings do |t|
      t.references :user, null: false, foreign_key: true
      t.date :marked_on

      t.timestamps
    end
  end
end
