class Bicycle
  attr_reader :size, :parts

  def initialize(attr)
    @size = attr[:size]
    @parts = attr[:parts]
  end

  def spares
    parts.spares
  end
end
require 'forwardable'
class Parts
  extend Forwardable
  attr_reader :parts
  def_delegators :@parts, :size, :each
  
  def initialize(attr)
    @parts = attr[:parts]
  end
  
  def spares
    parts.select{ |part| part.need_spare }
  end
end

class Part
  attr_reader :name, :description, :need_spare
  def initialize(attr)
    @name = attr[:name]
    @description = attr[:description]
    @need_spare = attr.fetch(:need_spare, true)
  end
end


chain = Part.new(name:'chain', description: '10-speed')
road_tire = Part.new(name:'tire_size', description: '23')
tape = Part.new(name: 'tape_color',description: 'red')
mountain_tire = Part.new(name: 'tire_size', description: '2.1')
rear_shock = Part.new(name: 'rear_shock', description: 'Fox')
front_shock = Part.new(name: 'front_shock', description: 'Manitou', need_spare: false)

road_bike_parts = Parts.new(parts:[chain, road_tire, tape])
road_bike = Bicycle.new(size: 'L', parts: road_bike_parts)
mountain_bike_parts = Parts.new(parts: [chain, mountain_tire, front_shock, rear_shock])
mountain_bike = Bicycle.new(size:'L', parts: mountain_bike_parts)

puts mountain_bike.spares
puts mountain_bike.size
puts road_bike.spares