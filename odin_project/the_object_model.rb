# How do we create an object in Ruby? Give an example of the creation of an object.

# class Person
#  include Drive
#  attr_reader :name
#  def initialize(name, age)
#    @name = name
#    @age = age
#  end

#  def speak(phrase)
#    puts phrase
#  end
#end

# What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

# a module is a way to define behaviors you want to use for multiple classes to write less code?

module Drive
  def can_do_this(action, name)
    puts "My name is #{name}, and I can #{action}!"
  end
end

class Person
  include Drive
  attr_reader :name
  attr_reader :age
  def initialize(name, age)
    @name = name
    @age = age
  end

  def speak(phrase)
    puts phrase
  end
end

bob = Person.new("Bob", 25)
bob.speak("Hello, my name is #{bob.name} and I am #{bob.age} years old!")
bob.can_do_this("drive", bob.name)
