class Slider < Widget
  attr_accessor :left
  
  def initialize(options = {})
    @bounds = stack :width => 200, :height => 50 do
      background white
      @knob = rect 0,0,10,50
      @knob.fill = purple
      
      @knob_half_width = @knob.width / 2
      
      @knob.click { start_dragging }
      @knob.release { stop_dragging }
      
      @timer = animate(48) { update_position if dragging? and within_bounds? }.stop
      
      click { update_position }
    end
  end
  
  def dragging?
    @dragging
  end
  
private
  def start_dragging
    @dragging = true
    @timer.start
  end
  
  def stop_dragging
    @dragging = false
    @timer.stop
  end
  
  def update_position
    self.left = @knob.left = mouse[1] - (@knob.width / 2)
  end
  
  def within_bounds?
    (mouse[1] > (@bounds.left)) and 
    (mouse[1] < (@bounds.width - @knob.width))
  end
end

Shoes.app :width => 400, :height => 200 do
  background purple
  @slider = slider
  @info = para
  every 0.1 do
    @info.replace @slider.left if @slider.dragging?
  end
end
