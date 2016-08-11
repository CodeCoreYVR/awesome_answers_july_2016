class QuestionsController < ApplicationController

  # GET /questions/new
  def new

    # we need to instantiate a new Question object because it will help us build
    # a form to create a question easily
    # @question = Question.new title: "abc"
    @question = Question.new

    # render :new
    # render "/questions/new"
  end

  def create
    # {
    #   "utf8": "✓",
    #   "authenticity_token": "...",
    #   "question": {
    #     "title": "asd fasdff",
    #     "body": "asdf asd f"
    #   },
    #   "commit": "Create Question",
    #   "controller": "questions",
    #   "action": "create"
    # }

    # we're using the `strong parameters` feature of Rails here to only allow
    # mass-assigning the attributes that we want to allow the user to set
    question_params  = params.require(:question).permit([:title, :body])
    @question        = Question.new question_params

    if @question.save
      # render :show

      # all the methods below will work to redirect the user:
      # redirect_to question_path({id: @question.id})
      # redirect_to question_path({id: @question})
      redirect_to question_path(@question)
      # redirect_to @question
    else
      render :new
    end
  end

  def show
    @question = Question.find params[:id]
  end

  def index
    @questions = Question.order(created_at: :desc)
  end

  def edit
    @question = Question.find params[:id]
  end

  def update
    @question = Question.find params[:id]
    if @question.update params.require(:question).permit([:title, :body])
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    question = Question.find params[:id]
    question.destroy
    redirect_to questions_path
  end

end
