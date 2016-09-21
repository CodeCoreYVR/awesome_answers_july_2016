function Question (props) {
  return (
    <section className="question">
      <h1>{props.title}</h1>
      <p>{props.body}</p>
      <button onClick={props.onBackClick}>Back</button>
    </section>
  );
}
