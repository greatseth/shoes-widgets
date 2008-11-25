class Slider < Widget
  attr_reader :percent
  
  def initialize(options = {})
    style :width => 200, :height => 50
    
    @percent = 0
    
    @bounds = stack :width => 200, :height => 50 do
      background white
      
      @knob = rect 0,0,10,50
      default_knob_fill
      
      @knob_half_width = @knob.width / 2
      
      @knob.hover { active_knob_fill }
      @knob.leave { default_knob_fill unless dragging? }
      
      @knob.click   { start_dragging }
      @knob.release { stop_dragging  }
      
      @timer = animate(48) { update_position if dragging? and within_bounds? }.stop
      
      click { update_position }
    end
  end
  
  def dragging?
    @dragging
  end
  
  def default_knob_fill
    @knob.fill = purple
  end
  
  def active_knob_fill
    @knob.fill = green
  end
  
  def start_dragging
    active_knob_fill
    @dragging = true
    @timer.start
  end
  
  def stop_dragging
    default_knob_fill
    @dragging = false
    @timer.stop
  end
  
  def update_position
    @knob.left = mouse[1] - (@knob.width / 2)
    @knob.left = @bounds.left if @knob.left < @bounds.left
    @knob.left = @bounds.width - @knob.width if @knob.left > @bounds.width - @knob.width
    
    @percent = (@knob.left.to_f / (@bounds.width - @knob.width).to_f) * 100
  end
  
  def within_bounds?
    (mouse[1] > @bounds.left) and (mouse[1] < @bounds.width)
  end
end

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
