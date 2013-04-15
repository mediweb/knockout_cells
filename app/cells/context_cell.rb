class ContextCell < Cell::Rails
  def main(options, inner_html)
    @args = options
    @inner_html = inner_html
    render
  end
  def form(options, inner_html)
    @args = options
    @inner_html = inner_html
    render
  end
  def ko_input(options)
    @field_name = options[:field_name]
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
