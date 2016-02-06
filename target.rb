input_x, input_y = ARGV.map!(&:to_i)

centre_point = [500, 500]
d1 = 200
d2 = 400
d3 = 600

class Target
  attr_reader :diameter, :centre_point

  def initialize(centre_point, diameter)
    @diameter = diameter
    @centre_point = centre_point
  end

  def hit?(x, y)
    (x - @centre_point[0])**2 + (y - @centre_point[1])**2 <= (@diameter / 2.0)**2
  end
end

case
when Target.new(centre_point, d1).hit?(input_x, input_y)
  puts 'Центр! - указка попала в первый круг'
when Target.new(centre_point, d2).hit?(input_x, input_y)
  puts 'Близко! - указка попала во второй круг'
when Target.new(centre_point, d3).hit?(input_x, input_y)
  puts 'Далеко! – указка попала в третий круг'
else
  puts 'Мимо! – указка не попала в цель'
end
