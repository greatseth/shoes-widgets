class LabeledCheck < Shoes::Widget
  def initialize text, options = {}, &block
    flow_styles! options
    
    @check = check &block
    para text, options
    
    click do
      @check.checked = !@check.checked?
      block.call @check
    end
  end
  
  def method_missing m,*a,&b
    if @check.respond_to? m
      @check.send m, *a, &b
    else
      super
    end
  end
  
private
  def flow_styles!(options)
    style Shoes::BASIC_S.inject({}) { |fs,s| fs.merge s => options.delete(s) }
  end
end
