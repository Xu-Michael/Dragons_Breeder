require_relative '../models/dragon'

class DragonController
  def initialize
    @view = DragonMenu.new
  end

  def list
    all_dragons = Dragon.all
    all_dragons.each { |dragon| dragon.set_size.set_value }
    @view.list_dragons(all_dragons)
  end

  def hatch
    purchase_info = @view.purchase_egg
    breed_rarity = Dragon.parameter_rating(purchase_info[:breed])
    pedigree = Dragon.parameter_rating(purchase_info[:pedigree])
    new_dragon = Dragon.new(name: purchase_info[:name], pedigree: pedigree, breed: Breed.assign(breed_rarity))
    @view.new_dragon(new_dragon)
  end

  def sell
    id = @view.ask_for_id
    sold_amount = Dragon.find(id).sell
    dragon_name = Dragon.find(id).name
    if sold_amount
      Dragon.destroy(id)
      @view.finish_sale(sold_amount, dragon_name)
    else
      @view.no_sale(dragon_name)
    end
  end
end
