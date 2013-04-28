class ContextCell < Cell::Rails
  helper_method :inner_html, :opts
  attr_accessor :inner_html, :opts

  def main(options, inner_html)
    @args = options
    @inner_html = inner_html
    render
  end
  def form
    @args = opts
    @inner_html = inner_html
    render
  end
  def ko_input
    @field_name = opts[:field_name]
    render
  end
  def fields_for(options, inner_html, &block)
    @model = options[:model]
    @inner_html = inner_html
    render
  end
  def submit
    render
  end
end
