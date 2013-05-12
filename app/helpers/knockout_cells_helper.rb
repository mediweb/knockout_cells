module KnockoutCellsHelper
  def ko_form_for(*args, &block)
    CellTree.build(:context, :form, self, *args, &block)
  end
  def ko_context(options, &block)
    render_cell :context, :main, options, capture(&block)
  end
end
