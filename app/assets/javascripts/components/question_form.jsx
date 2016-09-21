function QuestionForm (props) {
  function handleSubmit (event) {
    event.preventDefault();
    var form = event.target;

    var questionData = {
      title: form.querySelector('[name=title]').value,
      body: form.querySelector('[name=body]').value
    };

    if (typeof props.onSubmit === 'function') {
      props.onSubmit(questionData);
    }
  };

  return (
    <section className="question-form">
      <form onSubmit={handleSubmit}>
        <fieldset>
          <label htmlFor="title">Title</label>
          <input name="title"/>
        </fieldset>
        <fieldset>
          <label htmlFor="body">Body</label>
          <textarea name="body"/>
        </fieldset>
        <input type="submit" />
      </form>
    </section>
  )
};
