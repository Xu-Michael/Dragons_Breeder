class Post
  attr_reader :id
  attr_accessor :breed, :rarity, :pedigree, :value

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]   # Breed object with breed name and rarity
    @rarity = attributes[:rarity] || 0
    save
  end

# ============== Standard CRUD Methods ==============
  def save
    if @id
      DB.execute("UPDATE posts SET rarity = #{@rarity}, name = '#{@name}' WHERE id = #{@id}")
    else
      DB.execute("INSERT INTO posts (value, rarity, breed) VALUES ('#{@name}', #{@rarity}")
      @id = DB.last_insert_row_id
    end
  end

  def destroy
    DB.execute("DELETE FROM posts WHERE id = ?", @id)
  end

  def self.find(id)
    DB.results_as_hash = true
    breed_hash = DB.execute("SELECT * FROM posts WHERE posts.id = ?", id).first
    if breed_hash
      Post.new(id: breed_hash['id'], value: breed_hash['name'], rarity: breed_hash['rarity'])
    else
      return nil
    end
  end

  def self.all
    DB.results_as_hash = true
    DB.execute("SELECT * FROM breeds").map do |post|
      Breed.new(name: breed['name'], id: breed['id'], rarity: post['rarity'])
    end
  end
end
