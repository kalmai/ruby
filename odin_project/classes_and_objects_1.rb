# Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

class MyCar
  attr_accessor :year, :color, :model, :speed
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up
    self.speed += 5
  end

  def brake
    self.speed -= 5
  end

  def shut_the_car_off
    self.speed = 0
  end

# Add an accessor method to your MyCar class to change and view the color of your car. Then add an accessor method that allows you to view, but not modify, the year of your car.

  def change_color(c)
    self.color = c
  end

  def view_color
    self.color
  end

  def view_car_year
    self.year
  end

# You want to create a nice interface that allows you to accurately describe the action you want your program to perform. Create a method called spray_paint that can be called on an object and will modify the color of the car.
  def spray_paint(c)
    puts "You paint your car from #{color} to #{self.color = c}"
  end
end

honda = MyCar.new(2020, "blue", "civic")
10.times { honda.speed_up }
puts "the honda's current speed is #{honda.speed} after having sped up 10 times and now speed_up an additional 5 to result in #{honda.speed_up}"
puts "the honda brakes 5 mph to now have a speed of #{honda.brake}"
puts "the honda now turns off the engine and has a speed of #{honda.shut_the_car_off}"


puts honda.view_color
honda.change_color("pink")
puts honda.view_color

puts honda.view_car_year


# looking at the solution this can be done a lot easier by...
honda.color = "red"
puts honda.color
puts honda.year

puts honda.spray_paint("beige")
