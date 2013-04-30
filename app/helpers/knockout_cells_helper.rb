module KnockoutCellsHelper
  def form_for(*args, &block)
    KnockoutForm.build(:context, :form, self, *args, &block)
  end
  def ko_context(options, &block)
    render_cell :context, :main, options, capture(&block)
  end

  def ko_input(opts)
    render_cell :context, :ko_input do |c|
      c.opts = opts
    end
  end

  def ko_fields_for(options, &block)
    render_cell :context, :fields_for do |c|
      c.inner_html = capture(&block)
      c.opts = options
    end
  end

  def ko_submit
    render_cell :context, :submit
  end
end
