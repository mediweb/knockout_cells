class KnockoutForm
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

  def cell(name, opts={})
    Rails.logger.debug "------------------------ CELL opts: #{opts}"
    render_cell @name, @method, name do |c|
      c.inner_html = inner_html
      c.opts = opts
    end
  end

  def method_missing(method, *args, &block)
    Rails.logger.debug "------------------------ METHOD MISSING: #{method} #{args}"
    unless block_given?
      render_cell(@name, method, args[0]) do |c|
        c.opts = args[1]
      end
    else
      self.class.build(@name, method, self, *args, &block)
    end
  end
end
