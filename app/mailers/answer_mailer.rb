class AnswerMailer < ApplicationMailer

  def notify_question_owner(answer)
    @answer         = answer
    @question       = answer.question
    @question_owner = answer.question.user

    if @question_owner
      mail(to:      @question_owner.email ,
           subject: "You got new answer to your question")
    end
  end

end
