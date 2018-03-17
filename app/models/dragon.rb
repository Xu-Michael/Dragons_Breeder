require 'Time'
require_relative 'breed'
class Dragon
  attr_reader :id
  attr_accessor :breed, :size, :pedigree, :value

  def initialize(attributes = {})
    @id = attributes[:id]
    @breed = attributes[:breed]   # Breed object with breed name and rarity
    @size = attributes[:size] || 0
    @pedigree = attributes[:pedigree] || 0
    @value = attributes[:value] || 0
    @name = attributes[:name]
    @time = Time.now
  end

# ============== Standard CRUD Methods ==============
  def save
    if @id
      DB.execute("UPDATE posts SET size = #{@size}, breed_name = '#{@breed.name}', breed_rarity = #{@breed.rarity}, value = #{@value},
                                   pedigree = #{@pedigree}, value = #{@value}, name = '#{@name}', time = '#{@time}' WHERE id = #{@id}")
    else
      DB.execute("INSERT INTO posts (value, size, breed) VALUES ('#{@name}', '#{@breed.name}', #{@breed.rarity},
                                                                  #{@pedigree}, #{@size}, #{@value}, #{@time})")
      @id = DB.last_insert_row_id
    end
  end

  def destroy
    DB.execute("DELETE FROM posts WHERE id = ?", @id)
  end

  def self.find(id)
    DB.results_as_hash = true
    dragon_hash = DB.execute("SELECT * FROM dragons JOIN breeds ON breeds.id = dragons.breed_id WHERE posts.id = ?", id).first
    if dragon_hash
      Dragon.new(value: dragon_hash['value'], breed: Breed.new(dragon_hash['breed_name']), id: dragon_hash['id'], size: dragon_hash['size'])
    else
      return nil
    end
  end

  def self.all
    DB.results_as_hash = true
    DB.execute("SELECT * FROM posts").map do |post|
      Dragon.new(value: post['value'], breed: post['breed'], id: post['id'], size: post['size'])
    end
  end

# ============== Dragon Methods ==============
  def set_size
    time_count = (Time.now - @time) / 3_600
    @size += (time_count * (1 + ((@pedigree * 0.1) * 3))).round(1)
    self
  end

  def parameter_rating(cost)
    case cost
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
    end
  end

  def sell
    if @size < 2.5
      return false
    else
      return @size * (25_000 + (10_000 * @breed.rarity))
    end
  end
end
