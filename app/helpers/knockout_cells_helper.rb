module KnockoutCellsHelper
  def magic(&block)
      render_cell :magic, :foo do |cell|
        cell.inner_html = capture do
          KnockoutForm.new(cell).instance_eval(&block) if block_given?
        end
      end
  end
  class KnockoutForm
    def initialize(cell)
      @cell = cell
    end
    def method_missing(method, *args)
      @cell.render_state method
    end
  end
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
end
