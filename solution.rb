require 'date'
class Account
 attr_reader :apr, :credit_limit, :open_date
 attr_accessor :transactions

# User can view apr, credlimit, opendate, and modify transactions

 def initialize(apr, credit_limit, date=Date.today)
   @apr = (apr / 100.0 / 365)
   @credit_limit = credit_limit
   @open_date = Date.today
   @transactions = {}
# Every instance of Account objects have a an empty hash created at instantiation.
 end

 def add_charge(amount, date=Date.today)
  if validate_float(amount) == false
    return "Error. Please only enter valid currency denominations. Example: 100.25"
  # Screens out incorrectly formatted input
   if amount + current_balance > 1000
     raise ArgumentError.new("Over Limit!")
   else
     transactions[date.to_s] = amount
  # The hash's key becomes Date.today & its value is the amount
  # Current balance is not defined
   end
 end

 def add_payment(amount, date=Date.today)
   transactions[date.to_s] = amount * -1
 # The hash's key becomes Date.today & its value is the negative amount

 end

 def check_balance(day_number)
   balance = 0
   interest = 0
# Balance & interest are defined locally, set to 0   

   day_number.times do |day|
  # day_number is provided by the user when calling this method
  
  # A times loop
     if transactions[(@open_date + day).to_s]
  # If the key @open_date + day is true (exists? has occurred yet?)...
       balance += transactions[(@open_date + day).to_s]
  # Then the new balance = old balance + value of hash on inputted day  
     end
     interest += balance * @apr
  # New interest = interest + balance * apr
   end
   if day_number % 30 == 0
  #if the inputted day is on an interest accrual day
     (balance + interest).round(2)
  # Then return balance + interest as a figure in this currency format: x.xx
   else
     balance.round(2)
  # If the inputted day isn't an interest accrual day, then the balance does not have this month's interest applied to it.
   end
 end

 def current_balance
   dates = @transactions.keys
   p dates
# dates = all the timestamped dates that hash uses as keys
   balance = 0
   dates.each do |date|
     balance += transactions[date]
# For each recorded date, add/subtract the value (amounts) to the balance.
   end
   balance
# Return the updated balance.
 end
end


a = Account.new(35, 1000)
p a.add_charge(100)
p a.add_charge(500)
p a.current_balance

p a.check_balance(1)
# p a.current_balance





def balance_history(day)
   balance = 0
   interest = 0
   i = day
# Balance & interest are defined locally, set to 0   

   until i == 0 do  
     if history[(@inception_date + day).to_s] == false
      return "Error: Please enter a valid date."
# Screens incorrect date input
     else
       balance += history[(@inception_date + day).to_s]      
# Balance = previous balance + value of hash on specified day  
     end
     interest += balance * @apr
# Interest = balance (which may include previous interest) times apr
    i--
   end
    if day_number % 30 == 0
# If the inputted day is on an interest accrual day...
      (balance + interest)
# Then balance = balance + interest as a figure in this currency format: x.xx
    else
      balance
  # If the inputted day isn't an interest accrual day, then the balance does not have this month's interest applied to it.
    end
  end
