function new_timeline() {
  /* defining test timeline*/
  var lang = {
    timeline: [{
      type: 'survey-html-form',
      preamble: '<p> <b> Por favor rellene cada hueco con un nombre diferente: </b> </p>',
      html: '<p>  </p>' +
      '<p> <input name="Name1" type="text" id="Name1" /> y <input name="Name2" type="text" id="Name2" /> demostraron a través de acciones valientes lo importante que es ayudar a los demás. </p>',
      autofocus: "Name1"
    }],
    timeline_variables: test_stimuli,
  };
  return [lang];
}
