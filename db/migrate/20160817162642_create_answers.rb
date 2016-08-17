class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.text :body
      # this will create an integer field named: question_id
      # t.references can take extra options:
      # foreign_key: true - this creates a foeign key contraint in the DB
      # index: true - this creates an index on the question_id field
      t.references :question, foreign_key: true, index: true

      t.timestamps
    end
  end
end
