module KnockoutCellsHelper
  def ko_context(options, &block)
    render_cell :context, :main, options, capture(&block)
  end

  def ko_form(options, &block)
    render_cell :context, :form, options, capture(&block)
  end

  def ko_input(field_name)
    render_cell :context, :ko_input, :field_name => field_name
  end

  def ko_fields_for(options, &block)
    render_cell :context, :fields_for, options, capture(&block)
  end

  def ko_submit
    render_cell :context, :submit
  end

  class KnockoutForm
    attr_accessor :custom_bindings
    def initialize(view_context, options={})
      @view_context = view_context
      @options = options
    end
    def self.form_for(view_context, model, options={}, &block)
      a = KnockoutForm.new(view_context, options)
      a.form_for(model) do
        yield(a)
      end
    end
    def text_field(field_name, options={})
      @view_context.render "shared/bootstrap/input", field_name: field_name, options: options, scope: @scope
    end
    def submit(field_name, options={})
      @view_context.render "shared/bootstrap/submit", field_name: field_name, options: options
    end
    def fields_for(model=nil, &block)
      @scope = model
      @view_context.content_tag :div, "data-bind" => "with: $root.section($data,'#{model}',$data.data.#{model})".html_safe, &block
    end
    def select(field_name, options={})
      @view_context.render "shared/bootstrap/select", field_name: field_name, options: options, scope: @scope
    end
    def form_for(model=nil, &block)
      @scope = @options[:as]
      content = @view_context.capture do
        block.call(self)
      end
      @view_context.render "shared/bootstrap/form", model: model, content: content, options: @options
    end
  end
  def ko_form_for(model, options={}, &block)
    KnockoutForm.form_for(self, model, options, &block)
  end
end
