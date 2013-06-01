class ContextCell < Cell::Rails
  helper_method :inner_html, :opts
  attr_accessor :inner_html, :opts

  def main(opts={})
    @args = opts
    @inner_html = inner_html
    render
  end
  def ko_form_for(name, opts={})
    @opts = opts
    @opts[:model_name] = name
    @model = "model"
    @inner_html = inner_html
    render
  end
  def ko_input(name)
    @field_name = name
    render
  end
  def ko_fields_for(name)
    @model = name
    @inner_html = inner_html
    render
  end
  def ko_collection(name)
    @model = name
    @inner_html = inner_html
    render
  end
  def submit(name)
    render
  end
  def ko_select(name, opts={})
    @field_name = name
    @collection = opts[:collection] || []
    render :select
  end
  def ko_new(name, object, opts={})
    @name = name
    @object = object
    @target = name.to_s.pluralize
    @opts = opts
    render :ko_new
  end
  def ko_destroy
    render :ko_destroy
  end
end
