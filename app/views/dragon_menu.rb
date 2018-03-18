class DragonMenu
  def list_dragons(dragons)
    puts "===============Your Dragon Den==============\n"
    dragons.each do |dragon|
      puts "#{dragon.id}. #{dragon.name}----------"
      puts "Size: #{dragon.size}    Breed: #{dragon.breed.name}   #{dragon.breed.rarity}/10"
      puts "pedigree: #{dragon.pedigree}/10   Value: #{dragon.value}\n"
    end
  end

  def purchase_egg
    puts "===============Hatch A Dragon==============\n"
    print "How much you like to spend on finding a rare breed?\n > "
    breed_spending = gets.chomp.to_i
    print "How much you like to spend on the pedigree of your baby dragon?\n > "
    pedigree_spending = gets.chomp.to_i
    print "What would you like to name your new baby dragon as?\n > "
    name = gets.chomp.to_i
    { breed_amount: breed_spending, pedigree_amount: pedigree_spending, name: name }
  end

  def new_dragon(dragon)
    puts "****Congrats on hatching a new dragon!****"
    puts "#{dragon.name} was born!"
    puts "Size: #{dragon.size}    Breed: #{dragon.breed.name}   #{dragon.breed.rarity}/10"
    puts "pedigree: #{dragon.pedigree}/10   Value: #{dragon.value}\n"
  end

  def ask_for_id
    print "Please input the dragon id\n > "
    gets.chomp.to_i
  end

  def finish_sale(sold_amount, name)
    puts "****Congrats on selling #{name}!****"
    puts "You earned: #{sold_amount}"
  end

  def no_sale(name)
    puts "****Sorry but #{name} is not big enough to sell yet!****"
  end
end
