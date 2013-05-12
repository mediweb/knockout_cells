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
        @model[name] = ko.mapping.fromJS(value)

      @form_for = (model,options) ->
        new Form(model, options)

  class Form
    constructor : (model, options={})->
      @options = options
      @token = $("form").first().data("authenticity-token")
      @model = model
      @model_name = options.model_name
      @submit = (object)=>
        data = {}
        data[@model_name] = ko.mapping.toJS(@model, {ignore: ["__ko_mapping__"]})
        data.authenticity_token = @token
        $.ajax
          type: "POST"
          url: @options.url
          data: data
          success: (data) =>
            ko.mapping.fromJS(data, @model);
            return false
          error: ->
            console.log "error"

      @textField = (root, model_name) ->
        data = root.data[model_name]
        errors = ko.observableArray([])
        if root.data.errors
          for error in root.data.errors()
            for k,v of error
              errors().push v if k == model_name
        node = {v: data, errors: errors, label: model_name, name: model_name }
        root[model_name] = node
        return node

      @section = (root, model_name, data) ->
        node = {name: model_name, data : data, textField: root.textField, section: root.section }
        root[model_name] = node
        return node

      @data = @model

  $(".ko_context").each (index,c)->
    window.context = new Context(c)
    ko.applyBindings(context, c);
