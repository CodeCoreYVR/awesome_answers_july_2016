class Tagging < ApplicationRecord
  belongs_to :question
  belongs_to :tag

  validates :tag_id, uniqueness: { scope: :question_id }
end
