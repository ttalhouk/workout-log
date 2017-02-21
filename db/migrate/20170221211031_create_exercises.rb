class CreateExercises < ActiveRecord::Migration[5.0]
  def change
    create_table :exercises do |t|
      t.integer :duration
      t.text :workout
      t.references :user, foreign_key: true
      t.date :workout_date

      t.timestamps
    end
  end
end
