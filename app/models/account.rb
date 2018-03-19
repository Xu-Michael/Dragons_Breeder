class Account
  attr_reader :id
  attr_accessor :cash, :name

  def initialize(attributes = {})
    @id = attributes[:id]
    @cash = attributes[:cash] || 0
    @name = attributes[:name]
  end

  def save
    if @id
      DB.execute("UPDATE accounts SET name = '#{@name}', cash = #{@cash} WHERE id = ?", @id)
    else
      DB.execute("INSERT INTO accounts (name, cash) VALUES ('#{name}', #{cash})")
      @id = DB.last_insert_row_id
    end
  end

  def destroy
    DB.execute("DELETE FROM accounts WHERE id = ?", @id)
  end

  def self.find(id)
    DB.results_as_hash = true
    account_hash = DB.execute("SELECT * FROM accounts WHERE accounts.id = ?", id).first
    if account_hash
      Account.new(id: account_hash['id'], cash: account_hash['cash'], name: account_hash['name'])
    else
      return nil
    end
  end
end
