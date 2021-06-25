function new_timeline() {
  /* defining test timeline*/
  var instr = {
    timeline: [{
      type: "html-button-response",
      choices: ['Continuar'],
      stimulus: "<p> A continuación verá una serie de oraciones. Usted tendrá que insertar un nombre por cada hueco que vea.</p>",
      post_trial_gap: 500
  }],
  sample: {type: 'fixed-repetitions', size: 1}
};
return [instr];
}
