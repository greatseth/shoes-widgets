class Slider < Widget
  def initialize(options = {})
    @bounds = stack :width => 200, :height => 50 do
      background white
      @knob = rect 0,0,10,50
      @knob.fill = purple
      
      @knob_half_width = @knob.width / 2
      
      @knob.click { start_dragging }
      @knob.release { stop_dragging }
      
      @timer = animate(48) { update_position if @dragging and within_bounds? }.stop
      
      click { update_position }
    end
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
    @knob.left = mouse[1] - (@knob.width / 2)
  end
  
  def within_bounds?
    (mouse[1] > (@bounds.left + @knob_half_width)) and 
    (mouse[1] < (@bounds.width - @knob_half_width))
  end
end

Shoes.app :width => 400, :height => 200 do
  background purple
  @slider = slider
end
