function new_timeline() {
  /* defining test timeline*/
  var test = {
    timeline: [{
      type: 'survey-html-form',
      data: jsPsych.timelineVariable('data'),
      preamble: '<p> Por favor añada los nombres. </p>',
      function(data){
        var html_input = '<p>' + data.sentence1 + '</p> <p> <input name="Name1" type="text"/> y <input name="Name2" type="text"/>' + data.sentence2 + '</p>',
      },
      html: html_input
    }],
    timeline_variables: test_stimuli,
    randomize_order: true,
    repetitions: 1
  };
  return [test];
}