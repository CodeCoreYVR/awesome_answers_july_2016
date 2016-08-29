class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    question = Question.find params[:question_id]
    like     = Like.new user: current_user, question: question
    if !(can? :like, question)
      redirect_to root_path, alert: "access denied"
    elsif like.save
      # redirect_to(question_path(question), {notice: "Thanks for liking"})
      redirect_to question_path(question), notice: "Thanks for liking"
    else
      redirect_to question_path(question), alert: like.errors.full_messages.join(", ")
    end
  end

  def destroy
    question = Question.find params[:question_id]
    like     = Like.find params[:id]
    if can? :destroy, like
      like.destroy
      redirect_to question_path(question), notice: "Like removed!"
    else
      redirect_to root_path, alert: "access denied!"
    end
  end

end
