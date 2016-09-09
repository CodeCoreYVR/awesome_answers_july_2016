class AddSlugToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :slug, :string
  end
end
