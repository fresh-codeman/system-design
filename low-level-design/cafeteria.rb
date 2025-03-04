
# Default drive (for A)
module DefaultDrive
  def drive
    puts "Default driving behavior"
  end
end

# Drive for B & C
module CommonDrive
  def drive
    puts "Driving with the same algorithm for B and C"
  end
end

# Drive for D, E, F
module AdvancedDrive
  def drive
    puts "Driving with the advanced algorithm for D, E, and F"
  end
end

# Step 3: Define the Vehicle Class and Assign Strategies
class Vehicle
  def initialize
  end

  def drive
    raise NotImplementedError, "#{self.class} do not implement drive"
  end
end

# Step 4: Assign Appropriate Strategies to Subclasses
class A < Vehicle
  include DefaultDrive
  def initialize
  end
end

class B < Vehicle
  include CommonDrive
  def initialize
  end
end

class C < Vehicle
  include CommonDrive

  def initialize
  end
end

class D < Vehicle
  include AdvancedDrive
  def initialize
  end
end

class E < Vehicle
  include AdvancedDrive

  def initialize
  end
end

class F < Vehicle
  include AdvancedDrive

  def initialize
  end
end

# Step 5: Test the Implementation
vehicles = [A.new, B.new, C.new, D.new, E.new, F.new]

vehicles.each do |vehicle|
  vehicle.drive
end
