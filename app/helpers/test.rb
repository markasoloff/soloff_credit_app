require 'date'


class Account
 attr_reader :apr, :credit_limit, :open_date
 attr_accessor :transactions

 def initialize(apr, credit_limit, date=Date.today)
   @apr = (apr / 100.0 / 365)
   @credit_limit = credit_limit
   @open_date = Date.today
   @transactions = {}
 end

 def add_charge(amount, date=Date.today)
   if amount + current_balance > 1000
     raise ArgumentError.new("Over Limit!")
   else
     transactions[date.to_s] = amount
   end
 end

 def add_payment(amount, date=Date.today)
   transactions[date.to_s] = amount * -1
 end

 def check_balance(day_number)
   balance = 0
   interest = 0
   day_number.times do |day|
     if transactions[(@open_date + day).to_s]
       balance += transactions[(@open_date + day).to_s]
     end
     interest += balance * @apr
   end
   if day_number % 30 == 0
     (balance + interest).round(2)
   else
     balance.round(2)
   end
 end

 def current_balance
   dates = @transactions.keys
   balance = 0
   dates.each do |date|
     balance += transactions[date]
   end
   balance
 end
end
