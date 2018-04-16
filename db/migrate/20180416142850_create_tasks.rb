class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.boolean :done
      t.datetime :target_date
      t.datetime :completion_date
      t.references :todo, foreign_key: true

      t.timestamps
    end
  end
end
