module KnockoutCellsHelper
  def ko_context(*args, &block)
    #render_cell :context, :main, options, capture(&block)
    CellTree.build(:context, :main, self, *args, &block)
  end
end
