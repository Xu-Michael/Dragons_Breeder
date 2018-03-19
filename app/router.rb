class Router
  def initialize
    @controller = DragonController.new
    @running = true
  end

  def run
    print_welcome
    @controller.load_account
    while @running
      print_menu
      action = gets.chomp.to_i
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @controller.list
    when 2 then @controller.hatch
    when 3 then @controller.sell
    when 4 then @controller.explore_breeds
    when 5 then @controller.save_account
                stop
    end
  end

  def actions
    [
      "View all your dragons",
      "Hatch a new baby dragon",
      "Sell a dragon",
      "Research breeds",
      "Exit out of program"
    ]
  end

  def print_menu
    puts "\nCash: #{@controller.account.cash}\nWhat do you want to do?"
    actions.each_with_index do |action, index|
      puts "#{index + 1} - #{action}"
    end
    print "> "
  end

  def print_welcome
    puts "----------------------------"
    puts "Welcome to DragonBreeder"
    puts "----------------------------"
  end

  def stop
    @running = false
  end
end
