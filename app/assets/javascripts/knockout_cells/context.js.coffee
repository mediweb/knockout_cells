# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  class Context
    constructor : (context_tag)->
      @model=[]
      $(context_tag).find(".model").each (index,model) =>
        name = $(model).data("model-name")
        value = $(model).data("model-value")
        console.log name
        console.log value
        @model[name] = ko.mapping.fromJS(value)


  $(".ko_context").each (index,c)->
    window.context = new Context(c)
    console.log "context created"
    ko.applyBindings(context, c);
