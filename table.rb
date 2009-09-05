class Table < Shoes::Widget
  class ColumnWidths < Array
    def initialize(table)
      @table = table
    end
    
    def []=(i, value)
      @table.slot.contents.select { |s| s.class.name =~ /Stack|Flow/ }.each do |row|
        row.contents.select { |s| s.class.name =~ /Stack|Flow/ }[i].width = value
      end
    end
    
    def method_missing(m, *a, &b)
      slot.respond_to?(m) ? slot.send(m, *a, &b) : super
    end
  end
  
  attr_reader :slot, :headers, :rows, :column_widths
  
  def initialize(options = {}, &block)
    @slot = self
    
    @headers = []
    @rows    = Hash.new []
    
    @column_widths = ColumnWidths.new self
    
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
    f.contents.each_with_index do |c,i|
      c.width = 1 / f.contents.size.to_f
    end
    f
  end
end
