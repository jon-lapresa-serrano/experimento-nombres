# Sys.setlocale("LC_ALL","es_ES")

# # ####################################################
# # # This script makes a psychTestR implementation of
# # # Gender Names Task
# # # Date:2021
# # # Author: Jon Lapresa-Serrano
# # # Project group: X
# # ###################################################


library(htmltools)
library(psychTestR)
library(tibble)
library(shiny)
library(jspsychr)
library(dplyr)

# base_dir <- "/srv/shiny-server/experimento-TFM"
base_dir <- "/Users/jonla/Desktop/names_JLS"
jspsych_dir <- file.path(base_dir, "jspsych-6-3-1")

write_to_file <- function(json_object,file_name,var_name=NULL){
  OS_type = .Platform
  if(is.null(var_name)){
    # if(OS_type$OS.type == "windows"){
    #   fileConn<-file(file_name)
    #   writeLines(json_object, fileConn, useBytes=TRUE)
    #   close(fileConn)
    # }else{
      write(json_object, file=file_name)
    # }
  }else{
    # if(OS_type$OS.type == "windows"){
    #   fileConn<-file(file_name)
    #   writeLines(paste("var ",var_name,"= ", json_object), fileConn, useBytes=TRUE)
    #   close(fileConn)
    # }else{
      write(paste("var ",var_name,"= ", json_object), file=file_name)
    # }
  }
}

# create dataframe to define stimuli

# sentences with masculine forms
sent_masc = c("Los alumnos del instituto local tuvieron la excelente oportunidad de visitar el Museo Nacional del Prado.",
              "Los estudiantes de primer año tienen que matricularse al menos tres meses antes de comenzar los estudios.",
              "Los vecinos del portal número 21 votaron sobre la decisión de instalar un ascensor en el edificio.",
              "Los diputados de aquel entonces tomaron la decisión de derogar la Ley de Educación que había estado vigente desde 2003.",
              "Los clientes del hipermercado de la Gran Vía esperaron durante horas para el comienzo de las rebajas.",
              "Los profesores del centro educativo deben entregar su autoevaluación a través de un formulario que se encuentra en la página web oficial.",
              "Los abogados de todo bufete tienen que aprenderse el Código Penal y el Código Civil tan bien como se pueda.",
              "Los ministros del nuevo gabinete han de escogerse antes de que acabe el próximo mes.",
              "Los empresarios de esa compañía decidieron posponer la reunión y hacer un descanso con tal de poder comer el almuerzo en algún otro sitio.")


# sentences with neutral forms
sent_neut = c("Les alumnes del instituto local tuvieron la excelente oportunidad de visitar el Museo Nacional del Prado.",
              "Les estudiantes de primer año tienen que matricularse al menos tres meses antes de comenzar los estudios.",
              "Les vecines del portal número 21 votaron sobre la decisión de instalar un ascensor en el edificio.",
              "Les diputades de aquel entonces tomaron la decisión de derogar la Ley de Educación que había estado vigente desde 2003.",
              "Les clientes del hipermercado de la Gran Vía esperaron durante horas para el comienzo de las rebajas.",
              "Les profesores del centro educativo deben entregar su autoevaluación a través de un formulario que se encuentra en la página web oficial.",
              "Les abogades de todo bufete tienen que aprenderse el Código Penal y el Código Civil tan bien como se pueda.",
              "Les ministres del nuevo gabinete han de escogerse antes de que acabe el próximo mes.",
              "Les empresaries de esa compañía decidieron posponer la reunión y hacer un descanso con tal de poder comer el almuerzo en algún otro sitio.")


# sentences with collective forms
sent_coll = c("El alumnado del instituto local tuvo la excelente oportunidad de visitar el Museo Nacional del Prado.",
              "El estudiantado de primer año tiene que matricularse al menos tres meses antes de comenzar los estudios.",
              "El vecindario del portal número 21 votó sobre la decisión de instalar un ascensor en el edificio.",
              "La diputación de aquel entonces tomó la decisión de derogar la Ley de Educación que había estado vigente desde 2003.",
              "La clientela del hipermercado de la Gran Vía esperó durante horas para el comienzo de las rebajas.",
              "El profesorado del centro educativo debe entregar su autoevaluación a través de un formulario que se encuentra en la página web oficial.",
              "La abogacía de todo bufete tiene que aprenderse el Código Penal y el Código Civil tan bien como se pueda.",
              "El ministerio del nuevo gabinete ha de escogerse antes de que acabe el próximo mes.",
              "El empresariado de esa compañía decidió posponer la reunión y hacer un descanso con tal de poder comer el almuerzo en algún otro sitio.")

# sentences with gaps
sent_gaps = c("pensaron que fue una experiencia de lo más enriquecedora.",
              "se olvidaron de hacerlo y tuvieron que empezar un mes más tarde.",
              "debatieron sobre las diferencias de vivir en el primer piso o en el cuarto.",
              "aplaudieron enérgicamente al darse a conocer el resultado.",
              "incluso trasnocharon para no perderse los mejores precios.",
              "tardaron menos de media hora en completarlo y enviarlo con éxito.",
              "siempre tenían múltiples problemas porque sus memorias no eran muy buenas.",
              "tienen grandes esperanzas en que serán esenciales para la remodelación del Gobierno.",
              "siguieron comentando los detalles de la reunión en mitad del restaurante.")

# filler sentences with masculine forms
fill_masc = c("Los rebeldes de este instituto deberían pensar en el bien común y dejar de destrozar el edificio.",
              "Los criminales de la ciudad de San Francisco siempre han sido una gran influencia para la leyenda y fama de la isla de Alcatraz.",
              "Los jardineros del parque de la ciudad no deben abrir la verja hasta que sean las seis de la mañana.",
              "Los caballeros de la Mesa Redonda fueron el primer ejemplo de la clásica imagen de galantería y heroísmo que ahora tanto gusta en las películas.",
              "Los cantantes del Teatro Real verdaderamente enseñan todo el trabajo y entrenamiento que emplean en hacer una buena actuación.",
              "Los espectadores de ese programa de televisión han de aburrirse mucho con tantos anuncios.",
              "Los ciudadanos de esta provincia quieren ver cambios positivos en sus hogares durante los próximos cuatro años.",
              "Los directores de esa organización propusieron tener tres reuniones mensuales con tal de mantener la comunicación activa.",
              "Los militares de la tercera brigada se prepararon para cualquier situación que pudiera ocurrir aquella mañana.")

# filler sentences with neutral forms
fill_neut = c("Les rebeldes de este instituto deberían pensar en el bien común y dejar de destrozar el edificio.",
              "Les criminales de la ciudad de San Francisco siempre han sido una gran influencia para la leyenda y fama de la isla de Alcatraz.",
              "Les jardineres del parque de la ciudad no deben abrir la verja hasta que sean las seis de la mañana.",
              "Les caballeres de la Mesa Redonda fueron el primer ejemplo de la clásica imagen de galantería y heroísmo que ahora tanto gusta en las películas.",
              "Les cantantes del Teatro Real verdaderamente enseñan todo el trabajo y entrenamiento que emplean en hacer una buena actuación.",
              "Les espectadores de ese programa de televisión han de aburrirse mucho con tantos anuncios.",
              "Les ciudadanes de esta provincia quieren ver cambios positivos en sus hogares durante los próximos cuatro años.",
              "Les directores de esa organización propusieron tener tres reuniones mensuales con tal de mantener la comunicación activa.",
              "Les militares de la tercera brigada se prepararon para cualquier situación que pudiera ocurrir aquella mañana.")

# filler sentences with collective forms
fill_coll = c("La rebeldía de este instituto debería pensar en el bien común y dejar de destrozar el edificio.",
              "El crimen de la ciudad de San Francisco siempre ha sido una gran influencia para la leyenda y fama de la isla de Alcatraz.",
              "La jardinería del parque de la ciudad no debe abrir la verja hasta que sean las seis de la mañana.",
              "La caballería de la Mesa Redonda fue el primer ejemplo de la clásica imagen de galantería y heroísmo que ahora tanto gusta en las películas.",
              "El coro del Teatro Real verdaderamente enseña todo el trabajo y entrenamiento que emplean en hacer una buena actuación.",
              "La audiencia de ese programa de televisión ha de aburrirse mucho con tantos anuncios.",
              "La ciudadanía de esta provincia quiere ver cambios positivos en sus hogares durante los próximos cuatro años.",
              "La dirección de esa organización propuso tener tres reuniones mensuales con tal de mantener la comunicación activa.",
              "El ejército de la tercera brigada se preparó para cualquier situación que pudiera ocurrir aquella mañana.")

# filler sentences with gaps
fill_gaps = c("han de cumplir un grave castigo con tal de dar ejemplo al resto.",
              "son dos claros ejemplos de cómo las acciones mezquinas también pasan a ser historia.",
              "siempre llegan puntuales para no tener que esperar fuera hasta poder hacer su trabajo.",
              "demostraron a través de acciones valientes lo importante que es ayudar a los demás.",
              "literalmente han brillado esta noche.",
              "han dicho que han estado hasta quince minutos esperando a que se acabaran.",
              "mantienen la esperanza de que por fin podrán estar en una mejor vivienda.",
              "confirmaron que irían a todas las reuniones siempre y cuando no se hicieran durante el fin de semana.",
              "admitieron después haber pasado algo de miedo al ser ésta su primera experiencia de ese estilo.")

names_stim <- data.frame(stimulus = length(6*3),
                           # sentence = rep(stim, each=3),
                           stim_type = rep(c("1", "2", "3", "4", "5", "6"), each=9), 
                           id = "names_stim",
                           fontsize = "60pt",
                           lineheight = "normal") %>%
  mutate(stim_type = recode(stim_type, '1' = "sent_masc", '2' = "sent_neut", '3' = "sent_coll", '4' = "fill_masc", '5' = "fill_neut", '6' = "fill_coll"))

# line to make it a test:
# stroop_stim = stroop_stim[-c(21:(54*3)), ]

# write html definitions to the stimulus column
# note this could be added as a pipe to the above, setting df=.
names_stim$stimulus <- html_stimulus(df = names_stim, 
                                      html_content = "word",
                                      html_element = "p",
                                      column_names = c("color","fontsize","lineheight"),
                                      css = c("color", "font-size", "line-height"),
                                      id = "id")

# create json object from dataframe
stimulus_json <- stimulus_df_to_json(df = names_stim,
                                     stimulus = "stimulus",
                                     data = c("word","color","response","stim_type"))

# write json object to script
# write_to_script(stimulus_json,"test_stimuli")
# write_to_script(stimulus_prac_json,"prac_stimuli")
write_to_file(stimulus_json, paste0(base_dir, "/test_stimuli.js"), "test_stimuli")

###############################
##### jsPsych starts here #####
###############################

# # For jsPsych
# library_dir <- "jspsych/jspsych-6.1.0"
# custom_dir <- "jspsych/js"

head <- tags$head(
  # jsPsych files
  
  
  # If you want to use original jspsych.js, use this:
  includeScript(file.path(jspsych_dir, "jspsych.js")),
  
  # If you want to display text while preloading files (to save time), specify your intro_text
  # in jsPsych.init (in run-jspsych.js) and call jspsych_preloadprogressbar.js here:
  # includeScript(file.path(jspsych_dir, "plugins/jspsych_preloadprogressbar.js")),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-html-button-response.js")
    file.path(jspsych_dir, "plugins/jspsych-html-button-response.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-html-keyboard-response.js")
    file.path(jspsych_dir, "plugins/jspsych-html-keyboard-response.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-fullscreen.js")
    file.path(jspsych_dir, "plugins/jspsych-fullscreen.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-survey-text.js")
    file.path(jspsych_dir, "plugins/jspsych-survey-text.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-survey-multi-choice.js")
    file.path(jspsych_dir, "plugins/jspsych-survey-multi-choice.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-survey-html-form.js")
    file.path(jspsych_dir, "plugins/jspsych-survey-html-form.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-survey-html-form.js")
    file.path(jspsych_dir, "plugins/jspsych-instructions.js")
  ),
  
  # Custom files
  includeCSS(file.path(jspsych_dir, "css/jspsych.css"))
  # includeCSS("css/style.css")
)

#########

##Intro
ui_intro <- tags$div(
  head,
  includeScript(file.path(base_dir, "intro_text.js")),
  includeScript(file.path(base_dir, "intro-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

intro <- page(
  ui = ui_intro,
  label = "intro",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)
  
##Instructions
ui_instr <- tags$div(
  head,
  includeScript(file.path(base_dir, "instr-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

instr <- page(
  ui = ui_instr,
  label = "instr",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Experiment
ui_names <- tags$div(
  head,
  includeScript(file.path(base_dir, "names-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

names_exp <- page(
  ui = ui_names,
  label = "names_exp",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##SURVEY
#survey <- (

##Age, nationality and residence
ui_demographics <- tags$div(
  head,
  includeScript(file.path(base_dir, "demographics-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

demographics <- page(
  ui = ui_demographics,
  label = 'demographics',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Gender
ui_gender <- tags$div(
  head,
  includeScript(file.path(base_dir, "gender-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

gender <- page(
  ui = ui_gender,
  label = 'gender',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Education
ui_edu <- tags$div(
  head,
  includeScript(file.path(base_dir, "edu-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

education <- page(
  ui = ui_edu,
  label = 'education',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Language1
ui_lang1 <- tags$div(
  head,
  includeScript(file.path(base_dir, "lang1-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

lang1 <- page(
  ui = ui_lang1,
  label = 'lang1',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Language2
ui_lang <- tags$div(
  head,
  includeScript(file.path(base_dir, "lang_var.js")),
  includeScript(file.path(base_dir, "lang-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

lang <- page(
  ui = ui_lang,
  label = "lang",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Neurological disease
ui_neuro <- tags$div(
  head,
  includeScript(file.path(base_dir, "neuro-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

neuro <- page(
  ui = ui_neuro,
  label = "neuro",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Duplets
ui_duplet <- tags$div(
  head,
  includeScript(file.path(base_dir, "duplet-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

duplet <- page(
  ui = ui_duplet,
  label = "duplet",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Thanks
ui_thanks <- tags$div(
  head,
  includeScript(file.path(base_dir, "thanks_text.js")),
  includeScript(file.path(base_dir, "thanks-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

thanks <- page(
  ui = ui_thanks,
  label = "thanks",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE,
)

##Final
ui_final <- tags$div(
  head,
  includeScript(file.path(base_dir, "final-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

final <- page(
  ui = ui_final,
  label = "final",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE,
  final = TRUE
)

##elts
elts <- join(
  new_timeline(join(
   intro,
   # demographics,
   # gender,
   # education,
   # lang1,
   lang,
   # neuro,
   # duplet,
   elt_save_results_to_disk(complete = FALSE), # anything that is saved here counts as completed
   instr,
   names_exp,
   # elt_save_results_to_disk(complete = TRUE),
   thanks,
   final), default_lang = "es")
)

##exp
exp <- make_test(
   elts = elts,
   opt = test_options(title="Names Task, Aarhus 2021",
                      admin_password="", # write a secret password here
                      enable_admin_panel=TRUE,
                      languages="es",
                      researcher_email="201902476@post.au.dk",
                      # problems_info="?Tiene problemas con el experimento? Env?e un email a 201902476@post.au.dk",
                      display = display_options(
                        full_screen = TRUE,
                        # content_border = "0px",
                        # show_header = FALSE,
                        # show_footer = FALSE,
                        # left_margin = 0L,
                        # right_margin = 0L,
                        css = file.path(jspsych_dir, "css/jspsych.css")
       )))

shiny::runApp(exp)
