def measure(count = 1,&prc)
  times = []
  count.times do
    start = Time.now
    prc.call
    finish = Time.now
    times << finish-start
  end
  times.inject(:+)/(count.to_f)
end