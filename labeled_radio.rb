class LabeledRadio < Shoes::Widget
  def initialize text, options = {}, &block
    flow_styles! options
    
    @radio = radio &block
    para text, options
    
    click do
      @radio.checked = !@radio.checked?
      block.call @radio
    end
  end
  
  def method_missing m,*a,&b
    if @radio.respond_to? m
      @radio.send m, *a, &b
    else
      super
    end
  end
  
private
  def flow_styles!(options)
    style Shoes::BASIC_S.inject({}) { |fs,s| fs.merge s => options.delete(s) }
  end
end
