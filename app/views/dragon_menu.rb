class DragonMenu
  def list_dragons(dragons)
    puts "===============Your Dragon Den==============\n"
    dragons.each do |dragon|
      puts "\n#{dragon.id}. #{dragon.name}"
      puts "Size: #{dragon.size}    Breed: #{Breed.find(dragon.breed).name}   Rarity: #{Breed.find(dragon.breed).rarity}/10"
      puts "Pedigree: #{dragon.pedigree}/10   Value: #{dragon.value}"
      puts "-----------------------------------------\n"
    end
  end

  def purchase_egg(cash)
    puts "===============Hatch A Dragon==============\n"
    puts "                       Cash: #{cash}"
    print "How much you like to invest on finding a rare breed? (0 to skip, minimum 100000)\n > "
    breed_spending = gets.chomp.to_i
    print "How much you like to invest on the pedigree of your baby dragon? (0 to skip, minimum 100000)\n > "
    pedigree_spending = gets.chomp.to_i
    print "What would you like to name your new baby dragon as?\n > "
    name = gets.chomp
    { breed_amount: breed_spending, pedigree_amount: pedigree_spending, name: name }
  end

  def new_dragon(dragon)
    puts "\n****Congrats on hatching a new dragon!****"
    puts "#{dragon.name} was born!"
    puts "Size: #{dragon.size}    Breed: #{Breed.find(dragon.breed).name}   #{Breed.find(dragon.breed).rarity}/10"
    puts "pedigree: #{dragon.pedigree}/10   Value: #{dragon.value}\n"
  end

  def ask_for_id
    print "\nPlease input the dragon id\n > "
    gets.chomp.to_i
  end

  def ask_for_name
    print "\nPlease enter your name\n > "
    gets.chomp
  end

  def ask_for_rarity
    print "\nPlease input the rarity you like to search\n > "
    gets.chomp.to_i
  end

  def breed_view(breed)
    puts "\nName: #{breed.name}  Rarity: #{breed.rarity}"
  end

  def finish_sale(sold_amount, name)
    puts "\n****Congrats on selling #{name}!****"
    puts "You earned: #{sold_amount}\n"
  end

  def no_sale(name)
    puts "\nSorry but #{name} is not big enough to sell yet!"
    puts "We only want dragons size 2.5 meters or bigger.\n"
  end

  def not_enough
    puts "\nSorry, you do not have enough cash to make this hatch!\n"
  end

  def no_dragons
    puts "\n****Oh no you are dragonless! Hatch your first dragon by typing '2' at the menu.****\n"
  end
end
