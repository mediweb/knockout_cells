class ContextCell < Cell::Rails
  def main(options, inner_html)
    @args = options
    @inner_html = inner_html
    render
  end
end
