class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :created_on, :user_first_name,
             :user_last_name, :user

  has_many :answers

  def user
    { first_name: object.user_first_name, last_name: object.user_last_name }
  end

  def title
    # in this case `object` refers to the question object you're serializing
    object.title.titleize
  end

  def created_on
    # object.created_at.strftime("%Y-%B-%d")
    object.created_at.to_formatted_s(:long)
  end

end
