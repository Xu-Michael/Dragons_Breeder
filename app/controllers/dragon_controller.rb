require_relative '../models/dragon'
require_relative '../models/breed'
require_relative '../models/account'

class DragonController
  attr_reader :account

  def initialize
    @view = DragonMenu.new
  end

  def list
    all_dragons = Dragon.all
    if all_dragons.size == 0
      @view.no_dragons
    else
      all_dragons.each { |dragon| dragon.set_size.set_value }
      @view.list_dragons(all_dragons)
    end
  end

  def hatch
    purchase_info = @view.purchase_egg(@account.cash)
    if @account.cash >= (purchase_info[:breed_amount] + purchase_info[:pedigree_amount])
      breed_rarity = Dragon.parameter_rating(purchase_info[:breed_amount])
      pedigree = Dragon.parameter_rating(purchase_info[:pedigree_amount])
      breed = Breed.assign(breed_rarity)
      @account.cash -= (purchase_info[:breed_amount] + purchase_info[:pedigree_amount])
      new_dragon = Dragon.new(name: purchase_info[:name], pedigree: pedigree, breed: breed.id)
      @view.new_dragon(new_dragon)
      new_dragon.save
    else
      @view.not_enough
    end
  end

  def sell
    id = @view.ask_for_id
    sold_amount = Dragon.find(id).set_size.set_value.sell
    dragon_name = Dragon.find(id).name
    if sold_amount
      Dragon.find(id).destroy
      @account.cash += sold_amount
      @view.finish_sale(sold_amount, dragon_name)
    else
      @view.no_sale(dragon_name)
    end
  end

  def explore_breeds
    rarity = @view.ask_for_rarity
    @view.breed_view(Breed.assign(rarity))
  end

  def load_account
    if Account.find(1)
      @account = Account.find(1)
    else
      @account = Account.new(name: @view.ask_for_name)
    end
  end

  def save_account
    @account.save
  end
end
