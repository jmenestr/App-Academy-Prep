class Timer

  attr_reader  :time_string, :seconds
  def initialize
    @seconds = 0
    @time_string = "00:00:00"
  end

  def seconds=(seconds)
    @seconds = seconds
    set_time_string
  end

  def set_time_string
    times = []
    times << hours = (@seconds) / 3600
    times << minutes = (@seconds - hours*3600) / 60
    times << seconds = (@seconds - hours*3600 - minutes*60)
    @time_string = times.map {|time| time.to_s.rjust(2,"0")}.join(":")
  end

end