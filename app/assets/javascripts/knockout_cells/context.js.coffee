# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  class Context
    constructor : (context_tag)->
      @model=[]
      @form=[]
      $(context_tag).find(".model").each (index,model) =>
        name = $(model).data("model-name")
        value = $(model).data("model-value")
        @model[name] = ko.mapping.fromJS value, key: (item) ->
          return ko.utils.unwrapObservable(item.id);

      @form_for = (model,options) ->
        form = new Form(model, options)
        @form[model] = form
        form

  class Form
    constructor : (model, options={})->
      @visible = ko.observable(false)
      @toogleVisible = =>
        @visible(!@visible())
        return @visible()
      @options = options
      @token = $("form").first().data("authenticity-token")
      @model = model
      @model_name = options.model_name
      @deleteObject = (onSuccess)=>
        console.log @model.id()
        data = {}
        data[@model_name] = {id: @model.id()}
        $.ajax
          type: "DELETE"
          url: "#{@options.url}/#{@model.id()}"
          data: data
          success: (data) =>
            onSuccess

      @submit = (object)=>
        data = {}
        data[@model_name] = ko.mapping.toJSON(@model, {ignore: ["__ko_mapping__","errors"]})
        console.log "Sending"
        console.log data[@model_name]
        data.authenticity_token = @token
        $.ajax
          type: "POST"
          url: @options.url
          data: data
          success: (data) =>
            ko.mapping.fromJS(data, @model)
            @visible(false)
            return false
          error: ->
            console.log "error"

      @textField = (root, model_name) ->
        model = root.model[model_name]
        errors = ko.observableArray([])
        if root.model.errors
          for error in root.model.errors
            for k,v of error
              errors().push v if k == model_name
        node = {v: model, errors: errors, label: model_name, name: model_name }
        root[model_name] = node
        return node

      @section = (root, model_name) ->
        root.model[model_name] = ko.observable() unless root.model[model_name]
        node = {name: model_name, model : root.model[model_name], textField: root.textField, section: root.section, collection: root.collection }
        root[model_name] = node
        return node

      @collection = (root, model_name) ->
        collection = []
        root.model[model_name] = ko.observableArray() unless root.model[model_name]
        for item in root.model[model_name]()
          node = {name: model_name, model : item, textField: root.textField, section: root.section, collection: root.collection }
          collection.push node
        root[model_name] = collection
        return collection

  $(".ko_context").each (index,c)->
    window.context = new Context(c)
    ko.applyBindings(context, c);
