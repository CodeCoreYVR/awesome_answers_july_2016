class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    vote          = Vote.new vote_params
    vote.user     = current_user
    vote.question = question
    if vote.save
      redirect_to question_path(question), notice: "Voted!"
    else
      redirect_to question_path(question), alert: "Something is wrong!"
    end
  end

  def update
    vote.update vote_params
    redirect_to question_path(question), notice: "Vote updated"
  end

  def destroy
    vote.destroy
    redirect_to question, notice: "Vote removed!"
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end

  def question
    @question ||= Question.find params[:question_id]
  end

  def vote
    @vote ||= Vote.find params[:id]
  end

end
