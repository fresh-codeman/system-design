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