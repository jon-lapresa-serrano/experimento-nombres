function new_timeline() {
  /* defining test timeline*/
  var y_n = ["Sí ", "No ", "Prefiero no contestar "];

  var neuro = {
    timeline: [{
      type: "survey-multi-choice",
      questions: [
        {prompt: "¿Tiene usted un historial o padece actualmente de alguna enfermedad neurológica (incluyendo síntomas de déficit de atención)?", name: 'Disease', options: y_n, required: true}
      ],
      post_trial_gap: 500
  }],
  // timeline_variables: y_n,
  // sample: {type: 'fixed-repetitions', size: 1}
};
return [neuro];
}
