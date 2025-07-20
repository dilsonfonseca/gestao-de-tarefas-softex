class CreateTeamTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :team_tasks do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :status, null: false
      t.string :assigned_to, null: false
      t.date :due_date, null: false

      t.timestamps
    end
  end
end
