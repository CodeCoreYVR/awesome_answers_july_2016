class AddImageToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :image, :string
  end
end
