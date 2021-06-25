function new_timeline() {
  /* defining test timeline*/
  var y_n = ["Sí ", "No "];

  var duplet = {
    timeline: [{
      type: "survey-multi-choice",
      questions: [
        {prompt: "¿Ha realizado usted ya la encuesta de un experimento con un formato muy similar a ésta? Si lo ha hecho recordaría palabras de diferentes colores y pulsar las teclas de dirección de su teclado.", name: 'Duplet', options: y_n, required: true}
      ],
      post_trial_gap: 500
  }],
  // timeline_variables: y_n,
  // sample: {type: 'fixed-repetitions', size: 1}
};
return [duplet];
}
