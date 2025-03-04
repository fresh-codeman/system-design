# Solid principles
Solid principles are the conventions to write code.
reduce delicacy
ease to maintain code
improve readability
flexible software
reduce complexity
![solid principles](/assets/images/solid-principles.png)
## Single responsibility
A class should have only one reason to change.

### first challenge
You need to design a Logger system that writes logs to different outputs (console, file, and database). The logger should not handle how logs are saved—it should only generate log messages.
```ruby
# Logger class should only format messages
class Logger
  def format_message(message)
    "[LOG] #{Time.now}: #{message}"
  end
end

# Abstract class for log persistence
class LogPersist
  def save(_log)
    raise NotImplementedError, "#{self.class} must implement save method"
  end
end

# Logs to database
class DBLogPersist < LogPersist
  def save(log)
    puts "Saving log to database: #{log}"
  end
end

# Logs to a file
class FileLogPersist < LogPersist
  def initialize(filename)
    @filename = filename
  end

  def save(log)
    File.open(@filename, 'a') { |file| file.puts log }
    puts "Log persisted to #{@filename}"
  end
end

# Example Usage
logger = Logger.new
message = logger.format_message("Error occurred!")

db_logger = DBLogPersist.new
db_logger.save(message) # Save to DB

file_logger = FileLogPersist.new("logs.txt")
file_logger.save(message) # Save to File
```
## open closed principles
class should open for extension but closed for modification
### Challenge
refactor following class
```ruby
class Order
  attr_reader :total_amount, :discount_type

  def initialize(total_amount, discount_type)
    @total_amount = total_amount
    @discount_type = discount_type
  end

  def final_price
    if discount_type == :percentage
      total_amount * 0.9 # 10% discount
    elsif discount_type == :flat
      total_amount - 20 # Flat discount of $20
    else
      total_amount
    end
  end
end

order = Order.new(200, :percentage)
puts order.final_price # 180

```

Solution
```ruby
# Abstract class to enforce method implementation
class DiscountStrategy
  def final_price(total_amount)
    raise NotImplementedError, "#{self.class} must implement final_price method"
  end
end

class NoDiscount < DiscountStrategy
  def final_price(total_amount)
    total_amount
  end
end

class PercentagePriceCalculator < DiscountStrategy
  def final_price(total_amount)
    total_amount * 0.9
  end
end

class FlatPriceCalculator < DiscountStrategy
  def final_price(total_amount)
    total_amount - 20
  end
end

class Order
  attr_reader :total_amount, :discount_strategy

  def initialize(total_amount, discount_strategy)
    @total_amount = total_amount
    @discount_strategy = discount_strategy
  end

  def final_price
    discount_strategy.final_price(total_amount)
  end
end

# Example Usage
order1 = Order.new(200, PercentagePriceCalculator.new)
puts order1.final_price # 180.0

order2 = Order.new(200, FlatPriceCalculator.new)
puts order2.final_price # 180

order3 = Order.new(200, NoDiscount.new)
puts order3.final_price # 200

```
## liskov substitution principle
Subtypes must be substitutable for their base types without altering behavior.
Rfactor following
```ruby
class Bird
  def fly
    puts "I can fly!"
  end
  def make_sound
    puts "Generic bird sound!"
  end
end

class Sparrow < Bird
  def make_sound
    puts "Generic bird sound!"
  end
end

class Penguin < Bird
  def make_sound
    puts "Generic bird sound!"
  end
  def swim
    puts "I can swim!"
  end
end

sparrow = Sparrow.new
sparrow.fly # ✅ Works fine

penguin = Penguin.new
penguin.fly # ❌ But penguins can't fly! Violates LSP

```

Solution
```ruby
# Base Bird class
class Bird
  def make_sound
    puts "Generic bird sound!"
  end
end

# Separate Flyable module (only for birds that can fly)
module Flyable
  def fly
    puts "I can fly!"
  end
end

class Sparrow < Bird
  include Flyable
end

class Penguin < Bird
  def swim
    puts "I can swim!"
  end
end

# Example Usage
sparrow = Sparrow.new
sparrow.fly       # ✅ Works fine
sparrow.make_sound # ✅ Works fine

penguin = Penguin.new
penguin.swim      # ✅ Works fine
penguin.make_sound # ✅ Works fine
penguin.respond_to?(:fly) # ❌ Won't break because Penguin doesn't have `fly`

```
## interface segregation principle
A class should not be forced to implement methods it does not use.

```ruby
class Worker
  def work
    puts "Working..."
  end

  def eat
    puts "Eating..."
  end
end

class Robot < Worker
end

# Issue: Robots don't eat, but they still have the `eat` method!
robot = Robot.new
robot.eat # ❌ This doesn't make sense for a Robot!

```


Solution
```ruby
# Base Worker class
module Workable
  def work
    puts "Working..."
  end
end

# Separate behavior for eating
module Eatable
  def eat
    puts "Eating..."
  end
end

class HumanWorker
  include Workable
  include Eatable
end

class Robot
  include Workable
end

# Example Usage
human = HumanWorker.new
human.work  # ✅ "Working..."
human.eat   # ✅ "Eating..."

robot = Robot.new
robot.work  # ✅ "Working..."
robot.respond_to?(:eat) # ❌ Won't break because Robot doesn't have `eat`

```
## dependency inversion principle
High-level modules should not depend on low-level modules. Both should depend on abstractions.      

```ruby
class EmailNotifier
  def send_notification
    puts "Sending email notification..."
  end
end

class User
  def initialize
    @notifier = EmailNotifier.new # ❌ Tight coupling
  end

  def notify
    @notifier.send_notification
  end
end
```
Solution
```ruby
# Abstract Notifier Interface
module Notifier
  def send_notification
    raise NotImplementedError, "#{self.class} must implement send_notification"
  end
end

# Concrete Notifiers
class EmailNotifier
  include Notifier

  def send_notification
    puts "Sending email notification..."
  end
end

class SMSNotifier
  include Notifier

  def send_notification
    puts "Sending SMS notification..."
  end
end

class SlackNotifier
  include Notifier

  def send_notification
    puts "Sending Slack notification..."
  end
end

# User class now depends on an abstraction (Notifier)
class User
  def initialize(notifier)
    @notifier = notifier
  end

  def notify
    @notifier.send_notification
  end
end

# Example Usage
email_user = User.new(EmailNotifier.new)
email_user.notify  # ✅ "Sending email notification..."

sms_user = User.new(SMSNotifier.new)
sms_user.notify    # ✅ "Sending SMS notification..."

slack_user = User.new(SlackNotifier.new)
slack_user.notify  # ✅ "Sending Slack notification..."
```