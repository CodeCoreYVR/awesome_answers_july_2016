class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question

  def create
    vote          = Vote.new vote_params
    vote.user     = current_user
    vote.question = @question
    respond_to do |format|
      if vote.save
        format.html { redirect_to question_path(@question), notice: "Voted!" }
        format.js   { render :refresh_vote } # this renders /votes/refresh_vote.js.erb
      else
        format.html { redirect_to question_path(@question), alert: "Something is wrong!" }
        format.js   { render :refresh_vote }
      end
    end
  end

  def update
    vote.update vote_params
    respond_to do |format|
      format.html { redirect_to question_path(@question), notice: "Vote updated" }
      format.js   { render :refresh_vote }
    end
  end

  def destroy
    vote.destroy
    respond_to do |format|
      format.html { redirect_to @question, notice: "Vote removed!" }
      format.js   { render :refresh_vote }
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end

  def find_question
    @question ||= Question.friendly.find params[:question_id]
  end

  def vote
    @vote ||= Vote.find params[:id]
  end

end
