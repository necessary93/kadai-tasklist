class AddDedlineToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :dedline, :string
  end
end
