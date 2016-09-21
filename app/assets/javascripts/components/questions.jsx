function Questions (props) {
  var questions = props.questions;

  return (
    <ul className="questions">
    {
      questions.map(
        function (question) {
          return (
            <li key={question.id}>
              <a
                href="#"
                data-id={question.id}
                onClick={props.onClick}>
                {question.title}
                </a>
            </li>
          )
        }
      )
    }
    </ul>
  );
}
