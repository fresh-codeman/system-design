# Strategy pattern

following this video https://www.youtube.com/watch?v=u8DttUrXtEw&list=PL6W8uoQQ2c61X_9e6Net0WdYZidm7zooW&index=4

generally stratgies uses the interfaces to apply them. dynamic typed language do not have interfaces but have tow methods to do that "Abstract Base Class(ABC) and Duck Typing"

## about

The Strategy Pattern is a behavioral design pattern that allows you to define a family of algorithms, encapsulate them in separate classes, and make them interchangeable at runtime

![strategy pattern example](/assets/images/strategy-pattern-example.png)
Example:- two child classes A and C using same algorithm but they have to duplicate the code.

## Codding

try to find the problem with following code

```ruby
class Vehicle
    def drive
        "algorithm for default drive"
    end
end

class A < Vehicle
  def initialize(attr)
    @wheel = attr[:wheel]
    @engine = attr[:engine]
  end
end

class B < Vehicle
  def initialize(attr)
    @wheel = attr[:wheel]
    @engine = attr[:engine]
  end

  def drive
    "algorithm for CommonDrive"
  end
end

class C < Vehicle
  def initialize(attr)
    @wheel = attr[:wheel]
    @engine = attr[:engine]
  end

  def drive
    "algorithm for CommonDrive"
  end
end

class D < Vehicle
  def initialize(attr)
    @wheel = attr[:wheel]
    @engine = attr[:engine]
  end

  def drive
    "algorithm for advance drive"
  end
end

class E < Vehicle
  def initialize(attr)
    @wheel = attr[:wheel]
    @engine = attr[:engine]
  end

  def drive
    "algorithm for advance drive"
  end
end

class F < Vehicle
  def initialize(attr)
    @wheel = attr[:wheel]
    @engine = attr[:engine]
  end

  def drive
    "algorithm for advance drive"
  end
end
```

### here if you look closly we can see drive method is using getting duplicated.

solution using ABC

```ruby
# Step 1: Define the Strategy Interface
class DriveStrategy
  def drive
    raise NotImplementedError, "Subclasses must implement the drive method"
  end
end

# Step 2: Implement Different Driving Strategies

# Default drive (for A)
class DefaultDrive < DriveStrategy
  def drive
    puts "Default driving behavior"
  end
end

# Drive for B & C
class CommonDrive < DriveStrategy
  def drive
    puts "Driving with the same algorithm for B and C"
  end
end

# Drive for D, E, F
class AdvancedDrive < DriveStrategy
  def drive
    puts "Driving with the advanced algorithm for D, E, and F"
  end
end

# Step 3: Define the Vehicle Class and Assign Strategies
class Vehicle
  def initialize(drive_strategy)
    @drive_strategy = drive_strategy
  end

  def drive
    @drive_strategy.drive
  end
end

# Step 4: Assign Appropriate Strategies to Subclasses
class A < Vehicle
  def initialize
    super(DefaultDrive.new)
  end
end

class B < Vehicle
  def initialize
    super(CommonDrive.new)
  end
end

class C < Vehicle
  def initialize
    super(CommonDrive.new)
  end
end

class D < Vehicle
  def initialize
    super(AdvancedDrive.new)
  end
end

class E < Vehicle
  def initialize
    super(AdvancedDrive.new)
  end
end

class F < Vehicle
  def initialize
    super(AdvancedDrive.new)
  end
end

# Step 5: Test the Implementation
vehicles = [A.new, B.new, C.new, D.new, E.new, F.new]

vehicles.each do |vehicle|
  vehicle.drive
end

```

1. this is good but as you can see developer has to more causiouse if he misses the super call then he will get a error like "Vehical class: drive method does not defined for null"
   how to remove the super call we can use module for mixins

```ruby

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

```

Does Your Code Follow the Strategy Pattern?
No, your code does NOT fully follow the Strategy Pattern. Here’s why:

Tight Coupling Between Classes and Strategies

Each subclass (A, B, C, etc.) directly includes a module (DefaultDrive, CommonDrive, etc.).
This means the drive behavior is fixed at compile time and cannot be changed dynamically at runtime.
Lack of Separation Between Strategy and Context

In the Strategy Pattern, the behavior (strategy) should be encapsulated in separate classes and passed to the main class (Vehicle), instead of being inherited or included.
Your implementation mixes behavior (strategy) into the class itself, making it hard to modify behavior dynamically.

### Final code using duck typing

Ruby follows Duck Typing – "If it behaves like a duck, it’s a duck."

You don’t need explicit interfaces; you just assume objects will implement the required methods.

```ruby
# Step 1: Define the Strategy Interface
class DriveStrategy
  def drive
    raise NotImplementedError, "Subclasses must implement the drive method"
  end
end

# Step 2: Implement Concrete Strategies
class DefaultDrive < DriveStrategy
  def drive
    puts "Default driving behavior"
  end
end

class CommonDrive < DriveStrategy
  def drive
    puts "Driving with the same algorithm for B and C"
  end
end

class AdvancedDrive < DriveStrategy
  def drive
    puts "Driving with the advanced algorithm for D, E, and F"
  end
end

# Step 3: Define the Context (Vehicle Class)
class Vehicle
  attr_accessor :drive_strategy  # Allow changing the strategy at runtime

  def initialize(drive_strategy)
    @drive_strategy = drive_strategy
  end

  def drive
    @drive_strategy.drive
  end
end

# Step 4: Assign Strategies to Different Vehicles
a = Vehicle.new(DefaultDrive.new)  # A uses DefaultDrive
b = Vehicle.new(CommonDrive.new)   # B uses CommonDrive
c = Vehicle.new(CommonDrive.new)   # C uses CommonDrive
d = Vehicle.new(AdvancedDrive.new) # D uses AdvancedDrive
e = Vehicle.new(AdvancedDrive.new) # E uses AdvancedDrive
f = Vehicle.new(AdvancedDrive.new) # F uses AdvancedDrive

# Step 5: Test the Implementation
vehicles = [a, b, c, d, e, f]
vehicles.each(&:drive)

# Step 6: Dynamically Change Strategy at Runtime
puts "\nChanging A's driving strategy..."
a.drive_strategy = AdvancedDrive.new
a.drive

```
