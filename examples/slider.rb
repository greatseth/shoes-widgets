require "../slider"

Shoes.app :width => 400, :height => 200 do
  background purple
  
  stack :width => 200, :height => 200 do
    @slider = slider
  end
  
  @info = para
  
  every 0.1 do
    @info.replace @slider.percent if @slider.dragging?
  end
  
  release do
    @slider.stop_dragging if @slider.dragging?
  end
end
