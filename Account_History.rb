require 'rubygems'
require 'active_support/time'

class Account
 attr_reader :apr, :credit_limit, :inception_date
 attr_accessor :history

 def initialize(apr, credit_limit)
  # final ver date = DateTime.current!
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
       p "hello"
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
end

#   def clean_date(date)
#     return date.strftime("%m/%d/%Y at %I:%M%p")
#   end
# end

a = Account.new(35, 1000)
a.charge_card(500)
sleep(1)
# a.charge_card(200)
# sleep(1)
a.pay_balance(50)
sleep(1)

# p a.present_balance
# p a.present_balance
p a.total_outstanding_balance(10)
p a.present_balance
# p a.inception_date + 5
# p a.inception_date

p DateTime.current
sleep(1)
p DateTime.current

# p Time.now + 10.days
# puts Time.now - 24.days
