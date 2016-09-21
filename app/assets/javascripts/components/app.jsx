var BASE_URL = "http://localhost:3000/";
var API_URL = BASE_URL + "api/v1/";
var API_KEY = '441128745d5e27e11a3517961836de6109d989ca864cd9c7d28553a75de76207';

var App = React.createClass({
  getInitialState: function () {
    return {questions: []}
  },
  getQuestions: function (page) {
    $.get(
      API_URL + "questions",
      {page: page || 1, api_key: API_KEY},
      function (questions) {
        this.setState({
          questions: questions
        });
        // console.log(questions);
      }.bind(this)
    )
  },
  postQuestion: function (questionData) {
    $.post(
      API_URL + "questions",
      {question: questionData, api_key: API_KEY},
      function (response) {
        console.log(response);
        this.getQuestions();
      }.bind(this)
    )
  },
  getQuestion: function (id) {
    $.get(
      API_URL + "questions/" + id,
      {api_key: API_KEY},
      function (question) {
        this.setState({
          question: question
        });
        // console.log(question);
      }.bind(this)
    )
  },
  showQuestion: function (event) {
    event.preventDefault();

    var questionId = event.target.getAttribute('data-id');
    this.getQuestion(questionId);
  },
  createQuestion: function (questionData) {
    // console.log(questionData)
    this.postQuestion(questionData);
  },
  clearQuestion: function () {
    this.setState({question: null});
  },
  componentDidMount: function () {
    this.getQuestions();
  },
  render: function () {
    var question = this.state.question;
    var shownComponent;

    if (this.state.question) {
      // question = {id: 1, title: 'dasdasa', body: 'dasdasdas'}
      shownComponent = <Question onBackClick={this.clearQuestion} {...question} />;
      // <Question id={question.id} title={question.title} body={question.body}/>
    } else {
      shownComponent = <Questions onClick={this.showQuestion} questions={this.state.questions} />;
    }

    return (
      <section className="app">
        <QuestionForm onSubmit={this.createQuestion} />
        <h1>{question ? 'Question' : 'All Questions'}</h1>
        { shownComponent }
      </section>
    );
  }
});
