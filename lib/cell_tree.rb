class CellTree
  attr_accessor :parent, :inner_html
  delegate :capture, :render_cell, :to => :parent

  def self.build(name, method, parent, *args, &block)
    form = new(name, method, parent)
    form.inner_html = form.capture do
      form.instance_eval(&block) if block_given?
    end
    form.cell(*args)
  end

  def initialize(name, method, parent, &block)
    self.parent = parent
    @name = name
    @method = method
    @block = block if block_given?
  end

  def cell(*args)
    render_cell @name, @method, *args do |c|
      c.inner_html = inner_html
    end
  end

  def method_missing(method, *args, &block)
    unless block_given?
      render_cell(@name, method, *args)
    else
      self.class.build(@name, method, self, *args, &block)
    end
  end
end
