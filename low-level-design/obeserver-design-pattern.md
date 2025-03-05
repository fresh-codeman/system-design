# Observer design pattern
The Observer Pattern is useful when you need to establish a one-to-many dependency between objects, where multiple objects (observers) need to be notified of changes in a central object (subject) without tightly coupling them.
In Rails, prefer ActiveSupport::Notifications for built-in event handling.

## when to use
- When Multiple Objects Need to React to State Changes
Example: Stock Market System: A stock price change should notify multiple investors (observers) automatically.
- When Decoupling Components for Better Maintainability
When a new user signs up, multiple actions need to happen:
Send a welcome email.
Create a default profile.
Log analytics.
- When Implementing Real-Time Updates
Chat Application (WebSockets & ActionCable in Rails)
When a user sends a message, all connected clients (observers) should receive updates in real-time.
## 🔹 When NOT to Use the Observer Pattern
🚫 When you only have one dependent object.
→ If only one object depends on another, it's simpler to just call a method directly.

🚫 When performance is critical.
→ If there are many observers, notifying them can slow things down (solution: use background jobs).

🚫 When debugging is hard.
→ Since observers get notified implicitly, it can be harder to trace execution flow.


## Codding session
### Challenge
observe these. and then implement system such that on change of price of product costumer get notified.
```ruby
class Product
  def initialize(name, price)
    @name = name
    @price = price
  end

  def price=(new_price)
    @price = new_price
  end
end

class Customer
    def initialize(name)
      @name = name
    end
end
```
Solution
```ruby
class Product
  def initialize(name, price)
    @name = name
    @price = price
    @observers = [] # List of observers
  end

  def add_observer(observer)
    @observers << observer
  end

  def remove_observer(observer)
    @observers.delete(observer)
  end

  def price=(new_price)
    @price = new_price
    notify_observers
  end

  private

  def notify_observers
    @observers.each { |observer| observer.update(@name, @price) }
  end
end

class Customer
    def initialize(name)
        @name = name
    end
    def update(product_name, new_price)
        puts "Hey! The price of #{product_name} has changed to $#{new_price}!"
    end
end
```
### Challenge
read following implementation and create a system to notify to user if the market price increase a target value of user.
```ruby
class Share
  attr_reader :market_price, :base_price, :pe, :quantity
  def initialize(market_price, quantity, base_price, pe )
    @market_price = market_price
    @base_price = base_price
    @pe = pe
    @quantity = quantity
  end
  
  def total_wealth
    market_price * quantity
  end
  private
  
  attr_writer :market_price, :base_price, :pe, :quantity
end

class User
  def initialize(name, age)
    @name = name
    @age = age
  end
end
```
here is the solution for it

```ruby
class Share
  attr_reader :market_price, :base_price, :pe, :quantity

  def initialize(symbol, market_price, quantity, base_price, pe)
    @symbol = symbol
    @market_price = market_price
    @base_price = base_price
    @pe = pe
    @quantity = quantity
    @observers = {}  # Stores { user => target_price }
  end

  def add_observer(user, target_price)
    @observers[user] = target_price
  end

  def remove_observer(user)
    @observers.delete(user)
  end

  def update_market_price(new_price)
    @market_price = new_price
    notify_observers
  end

  def to_s
    @symbol
  end

  private

  def notify_observers
    @observers.each do |user, target_price|
      if market_price >= target_price
        user.update(self, target_price)
      end
    end
  end
end
class User
  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def update(share, target_price)
    puts "📢 Alert: #{name}, the share price of #{share} has reached #{share.market_price}, crossing your target of #{target_price}!"
  end
end
```

