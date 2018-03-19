require_relative 'breed'

class Dragon
  attr_reader :id
  attr_accessor :breed, :size, :pedigree, :value, :name

  def initialize(attributes = {})
    @id = attributes[:id]
    @breed = attributes[:breed]   # Breed object with breed name and rarity
    @size = attributes[:size] || 0
    @pedigree = attributes[:pedigree] || 0
    @value = attributes[:value] || 0
    @name = attributes[:name]
    @age = attributes[:age] || Time.now
  end

# ============== Standard CRUD Methods ==============
  def save
    if @id
      DB.execute("UPDATE dragons SET size = #{@size}, value = #{@value}, pedigree = #{@pedigree},
                  name = '#{@name}', age = #{@age}, breed_id = #{@breed} WHERE id = ?", @id)
    else
      DB.execute("INSERT INTO dragons (name, breed_id, pedigree, size, value, age)
                  VALUES ('#{@name}', #{@breed}, #{@pedigree}, #{@size}, #{@value}, datetime('now'))")
      @id = DB.last_insert_row_id
    end
  end

  def destroy
    DB.execute("DELETE FROM dragons WHERE id = ?", @id)
  end

  def self.find(id)
    DB.results_as_hash = true
    dragon_hash = DB.execute("SELECT * FROM dragons WHERE dragons.id = ?", id).first
    if dragon_hash
      Dragon.new(id: dragon_hash['id'], breed: dragon_hash['breed_id'], value: dragon_hash['value'], size: dragon_hash['size'], pedigree: dragon_hash['pedigree'], name: dragon_hash['name'], age: dragon_hash['age'])
    else
      return nil
    end
  end

  def self.all
    DB.results_as_hash = true
    DB.execute("SELECT * FROM dragons").map do |dragon|
      Dragon.new(id: dragon['id'], breed: dragon['breed_id'], value: dragon['value'], size: dragon['size'], pedigree: dragon['pedigree'], name: dragon['name'], age: dragon['age'])
    end
  end

# ============== Dragon Methods ==============
  def set_size
    age_count = (Time.now - Time.parse(@age)) / 12_000
    @size += (age_count * (1 + ((@pedigree * 0.1) * 3))).round(1)
    self
  end

  def self.parameter_rating(amount_spent)
    case amount_spent
    when 100_000
      return rand(0..3)
    when 250_000
      return rand(1..5)
    when 500_000
      return rand(3..7)
    when 1_000_000
      return rand(4..8)
    when 1_250_000
      return rand(5..10)
    else
      return 0
    end
  end

  def set_value
    @value = (@size * (25_000 + (10_000 * Breed.find(@breed).rarity))).to_i
    self
  end

  def sell
    if @size < 2.5
      return false
    else
      @value
    end
  end
end
