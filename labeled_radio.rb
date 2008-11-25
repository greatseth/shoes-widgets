class LabeledRadio < Shoes::Widget
  def initialize text, options = {}, &block
    style :width => options.delete(:width)
    @radio = radio &block
    para text, options
    click { @radio.checked = !@radio.checked? }
  end
  
  def method_missing m,*a,&b
    if @radio.respond_to? m
      @radio.send m, *a, &b
    else
      super
    end
  end
end
