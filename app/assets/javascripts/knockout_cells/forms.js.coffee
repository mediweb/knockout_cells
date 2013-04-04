# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  class FormBuilder
    constructor : (form_tag)->
      @token = $(form_tag).data("authenticity-token")
      @model = ko.mapping.fromJS($(form_tag).data("model"))
      @raw_data = $(form_tag).data("model")
      @submit = (object)=>
        $.ajax
          type: "POST"
          url: @options.url
          data: {person: ko.mapping.toJS(object.data), authenticity_token: @token}
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
        node = {name: model_name, data : data }
        root[model_name] = node
        return node

      @form = (@options)=>
        {data: @model }

  $("form.ko_form").each (index,form)->
    window.fb = new FormBuilder(form)
    ko.applyBindings(fb, form);
