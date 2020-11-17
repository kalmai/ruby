# Create a module that you can mix in to ONE of your subclasses that describes a behavior unique to that subclass.

module Towable
  def prints_available_action
    puts "I can tow stuff"
  end
end

# Create a superclass called Vehicle for your MyCar class to inherit from and move the behavior that isn't specific to the MyCar class to the superclass. Create a constant in your MyCar class that stores information about the vehicle that makes it different from other types of Vehicles.
#
# Then create a new class called MyTruck that inherits from your superclass that also has a constant defined that separates it from the MyCar class in some way.

class Vehicle
  @@car_count = 0
  attr_accessor :year, :color, :model, :speed
  def initialize(year,color,model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@car_count += 1
  end

  def self.gas_mileage(miles, gallons)
    "your mileage on your trip was #{miles/gallons} mpg"
  end

# Add a class variable to your superclass that can keep track of the number of objects created that inherit from the superclass. Create a method to print out the value of this class variable as well.

  def self.print_car_count
    @@car_count == 1 ? "you have #{@@car_count} vehicle" : "you have #{@@car_count} vehicles"
  end

# Write a method called age that calls a private method to calculate the age of the vehicle. Make sure the private method is not available from outside of the class. You'll need to use Ruby's built-in Time class to help. def age

  def age
    calculate_vehicle_age
  end

  private
  def calculate_vehicle_age
    this_year = Time.now.year
    this_year - @year
  end

end

class MyCar < Vehicle
  CUSTOM_CONST = 0
end

class MyTruck < Vehicle
  CUSTOM_CONST_2 = 0
  include Towable
end

civic = MyCar.new(2020,"blue","civic")
raptor = MyTruck.new(2018,"red","raptor")
raptor.prints_available_action

puts Vehicle::gas_mileage(100, 20)

puts Vehicle::print_car_count

#  Print to the screen your lookup for the classes that you have created.

puts MyCar.ancestors
puts
puts MyTruck.ancestors
puts
puts Vehicle.ancestors

puts raptor.age

# Create a class 'Student' with attributes name and grade. Do NOT make the grade getter public, so joe.grade will raise an error. Create a better_grade_than? method, that you can call like so...
#
#puts "Well done!" if joe.better_grade_than?(bob)

puts

class Student

  attr_reader :name, :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def self.better_grade_than?(s1,s2)
    s1.grade > s2.grade ? "Well done #{s1.name.capitalize}!" : "Better luck next time #{s1.name.capitalize}"
  end
end

joe = Student.new("joe", 50)
zach = Student.new("zach",70)

puts Student.better_grade_than?(zach,joe)
puts Student.better_grade_than?(joe,zach)
