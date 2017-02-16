#Solar System is a program that creates a solar system
#Consisting of different planets, and then outputs
#Information about the planets for the user

#Making the class Planet, which takes in information about each planet
class Planet
  attr_reader :name, :diameter, :mass, :moons, :distance_from_sun,
  :revolution_time

  # Initializing values based on the hash given to it
  def initialize(planet_hash)
    @name = planet_hash[:name]
    @diameter = planet_hash[:diameter]
    @mass = planet_hash[:mass]
    @moons = planet_hash[:moons]
    @distance_from_sun = planet_hash[:distance_from_sun]
    @revolution_time = planet_hash[:revolution_time]
  end

end

#Making the class Solar System, which takes in multiple Planet objects
class SolarSystem
  attr_accessor :planets
  attr_reader :name, :formation

  #Initializes with just a name and # of billions of years ago
  # the system formed
  def initialize(name, formation)
    @name = name
    @planets = []
    @formation = formation
  end

  #Method to add a Planet object to the solar system
  def add_planet(p)
    @planets.push(p)
  end

  #Method to calculate distances in AU between two planets
  def planet_distance(planet_one, planet_two)
    return (planet_two.distance_from_sun - planet_one.distance_from_sun).abs
  end

  #Method to calculate local age of a planet
  def planet_year(revolution)
    formation = @formation
    formation = formation * (10 ** 9)
    return Integer(formation/revolution)
  end

  #Method that outputs info about a planet chosen by the user
  def planet_info(planet)
    #Make sure the random planet is not referencing the planet chosen
    rand_planet = @planets.sample
    until rand_planet.name != planet.name
      rand_planet = @planets.sample
    end
    puts "#{planet.name} is a great planet!"
    puts "#{planet.name} has a diameter of #{planet.diameter} miles! Wow!"
    puts "It also has a mass of #{planet.mass} Earth Masses as well as #{planet.moons} moon(s)"
    puts "#{planet.name} is #{planet_year(planet.revolution_time)} years old in local time."
    puts "Here's a random fact! #{planet.name} and #{rand_planet.name} are #{planet_distance(rand_planet, planet)} AUs away from each other!"
    puts "Finally, #{planet.name} is #{planet.distance_from_sun} AUs away from the sun!"
  end



end

planets = []
again = true

#Creating an object for each planet and pushing it into an array
# Diameter in miles, mass in Earth Masses, Distance in AU, revolution time in days
planets << Planet.new(name: "Mercury", diameter: 3032, mass: 0.055, moons: 2,
distance_from_sun: 0.4, revolution_time: 88.0)
planets << Planet.new(name: "Venus", diameter: 7520.8, mass: 0.815, moons: 0,
distance_from_sun: 0.7, revolution_time: 224.7)
planets << Planet.new(name: "Earth", diameter: 7917.5, mass: 1.00, moons: 1,
distance_from_sun: 1, revolution_time: 365.2)
planets << Planet.new(name: "Mars", diameter: 4212, mass: 0.107, moons: 2,
distance_from_sun: 1.5, revolution_time: 687)
planets << Planet.new(name: "Jupiter", diameter: 8681.4, mass: 318, moons: 53,
distance_from_sun: 5.2, revolution_time: 4328.9)
planets << Planet.new(name: "Saturn", diameter: 72367.4, mass: 95, moons: 53,
distance_from_sun: 9.5, revolution_time: 10752.9)
planets << Planet.new(name: "Uranus", diameter: 31518, mass: 14, moons: 27,
distance_from_sun: 19.2, revolution_time: 30660)
planets << Planet.new(name: "Neptune", diameter: 30599, mass: 17, moons: 14,
distance_from_sun: 30.1, revolution_time: 60225)

#Name of solar system, formation years in billions of years ago
milky_way = SolarSystem.new("Milky Way", 4.6)

#Add each Planet object into the Solar System object
planets.each do |planet|
  milky_way.add_planet(planet)
end

#Method that outputs the prompt for the user to choose a planet to learn about
#Takes in the solar system object
def prompt(system)
  puts "Welcome to the planet explorer! Here are a list of planets you can learn about!"
  system.planets.each_with_index do |planet, index|
    puts "#{index + 1}. #{planet.name}"
  end
  puts "What planet would you like to learn about? (1-8)"
  answer = gets.chomp
  arr = (1..8).to_a.map {|a| a.to_s}
  until arr.include? answer
    puts "Please put in a valid number"
    answer = gets.chomp
  end
  answer = Integer(answer)
  index = answer - 1
  planet_chosen = system.planets[index]
  system.planet_info(planet_chosen)
end

#Keep asking the user for a planet until they indicate n
while again == true
  puts "The #{milky_way.name} solar system was formed #{milky_way.formation} billion years ago."
  prompt(milky_way)
  puts "Would you like to learn about another planet? y/n"
  answer = gets.chomp
  if answer == "y"
    again = true
  else
    again = false
  end
end
