class ContextCell < Cell::Rails
  helper_method :inner_html, :opts
  attr_accessor :inner_html, :opts

  def main(options, inner_html)
    @args = options
    @inner_html = inner_html
    render
  end
  def form(name)
    @args = opts
    @args[:model_name] = @args[:model_name] || name
    @model = name
    @inner_html = inner_html
    render
  end
  def ko_input(name)
    @field_name = name
    render
  end
  def fields_for(name)
    @model = name
    @inner_html = inner_html
    render
  end
  def submit(name)
    render
  end
  def ko_select(name)
    @field_name = name
    @collection = opts[:collection] || []
    render :select
  end
end
