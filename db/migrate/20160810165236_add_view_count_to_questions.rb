class AddViewCountToQuestions < ActiveRecord::Migration[5.0]
  def change
    # add_column is a migration method that takes 3 arguements
    # 1. Table name: questions
    # 2. Column Name: view_count
    # 3. Column Type: integer
    add_column :questions, :view_count, :integer
  end
end
