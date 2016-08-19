class AddUserReferencesToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_reference :questions, :user, foreign_key: true
  end
end
