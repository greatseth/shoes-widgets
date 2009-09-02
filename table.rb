class Table < Shoes::Widget
  def initialize(options = {}, &block)
    @headers = []
    @rows    = Hash.new []
    
    @options = {
      :width => 1.0
    }.merge(options)
    
    if b = @options[:background]
      background @default_bg = b
    end
    
    if @options[:border]
      border @options[:border]
    end
    
    style @options
    
    instance_eval &block
  end
  
  def header(*titles)
    @row_even = true
    @headers << rowflow { titles.each { |x| header_column x } }
  end
  
  def row(*values)
    @row_even = !@row_even
    @rows[@headers.last] << rowflow { values.each { |x| row_column x } }
  end
  
private
  def header_column(x)
    flow do
      background black
      border white
      para x, :stroke => white
    end
  end
  
  def default_bg_color
    white
  end
  
  def default_stroke_color
    black
  end
  
  def row_column(x)
    flow do
      background row_bg_color
      border default_stroke_color
      para x, :stroke => default_stroke_color
    end
  end
  
  def row_bg_color
    if @row_even
      @options[:zebra] || @options[:background] || default_bg_color
    else
      default_bg_color
    end
  end
  
  def rowflow
    f = flow(:width => 1.0) { yield }
    f.contents.each { |c| c.width = 1 / f.contents.size.to_f }
    f
  end
end
