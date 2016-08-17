class AnswersController < ApplicationController

  def create
    # we instantiate a new answer object based on the params we got from the
    # user. We use: params.require(:answer).permit(:body) as it's required part
    # of Rails for security reason (Strong Parameters)
    @answer = Answer.new params.require(:answer).permit(:body)

    # We fetch the question by its id which came from the URL. In the form in
    # the question/show.html.erb we used a url: question_answers_path(@question)
    # this path includes a variable :question_id which comes as part of the params
    @question = Question.find params[:question_id]

    # We associate the answer we defined above with the question we found above
    # as well. This is because we need to associate the created answer with the
    # question
    # answer.question_id = question.id
    @answer.question = @question

    # we same the answer to the database
    if @answer.save
      # we redirect to the question show page
      redirect_to question_path(@question), notice: "Answer created!"
    else
      flash[:alert] = "Please fix errors below"
      render "/questions/show"
    end
  end


  def destroy
    q = Question.find params[:question_id]
    a = Answer.find params[:id]
    a.destroy
    redirect_to question_path(q), notice: "Answer deleted"
  end
end
