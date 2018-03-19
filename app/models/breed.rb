class Breed
  attr_reader :id
  attr_accessor :rarity, :name

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]   # Breed object with breed name and rarity
    @rarity = attributes[:rarity] || 0
  end

# ============== Standard CRUD Methods ==============
  def save
    if @id
      DB.execute("UPDATE breeds SET rarity = #{@rarity}, name = '#{@name}' WHERE id = #{@id}")
    else
      DB.execute("INSERT INTO breeds (value, rarity, breed) VALUES ('#{@name}', #{@rarity}")
      @id = DB.last_insert_row_id
    end
  end

  def destroy
    DB.execute("DELETE FROM breeds WHERE id = ?", @id)
  end

  def self.find(id)
    DB.results_as_hash = true
    breed_hash = DB.execute("SELECT * FROM breeds WHERE breeds.id = ?", id).first
    if breed_hash
      Breed.new(id: breed_hash['id'], name: breed_hash['name'], rarity: breed_hash['rarity'])
    else
      return nil
    end
  end

  def self.assign(rating)
    DB.results_as_hash = true
    breed_hash = DB.execute("SELECT * FROM breeds WHERE rarity = ?", rating).flatten.sample
    Breed.new(id: breed_hash['id'], name: breed_hash['name'], rarity: breed_hash['rarity'])
  end

  def self.all
    DB.results_as_hash = true
    DB.execute("SELECT * FROM breeds").map do |breed|
      Breed.new(name: breed['name'], id: breed['id'], rarity: breed['rarity'])
    end
  end
end
