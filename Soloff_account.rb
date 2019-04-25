require 'rubygems'
require 'active_support/time'

class Account
 attr_reader :apr, :credit_limit, :inception_date
 attr_accessor :history

 def initialize(apr, credit_limit)
   @apr = (apr/100.0/365)
   @credit_limit = credit_limit
   @inception_date = DateTime.current
   @interest = 0
   @history = {}
 end

  def present_balance
    balance = 0
    @history.keys.each do |event|
     balance += history[event]
    end
    balance
  end

 def charge_card(sum)
  if validate_float(sum) == false
    "Error: Please enter valid currency denominations. Example: 100.25"
  elsif (present_balance + sum) <= credit_limit
    history[(DateTime.current).to_s] = sum
  end
 end 

 def pay_balance(sum)
   history[(DateTime.current).to_s] = -(sum)
 end

 def total_outstanding_balance(days_since_inception)
   interest = 0
   balance = 0
   days_since_inception.times do |day|
     if history[(@inception_date + day).to_s]
       balance += history[(@inception_date + day).to_s]
     end
     interest += balance * @apr
   end
   if days_since_inception % 30 == 0
      (balance + interest).round(2)
   else
     balance.round(2)
   end
 end
  

  def validate_float(input)
    return false unless input == input.to_f 
    return false unless input == input.round(2)
    true
  end  
################################################
# The methods are for testing purposes only:

 def charge_card_time_machine(sum)
    history[(DateTime.current + 25).to_s] = sum
 end
 
 def pay_balance_time_machine(sum)
    history[(DateTime.current + 15).to_s] = -(sum)
 end

 ###############################################
end

a = Account.new(35, 1000)
a.charge_card(500)
p a.total_outstanding_balance(30)
a.pay_balance_time_machine(200)
a.charge_card_time_machine(100)
p a.total_outstanding_balance(30)
