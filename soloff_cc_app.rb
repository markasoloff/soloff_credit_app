require 'date'
require'time'
# require 'Account_History.rb'
# require 'bigdecimal'

class Account
  attr_reader :start_date, :apr, :credit_limit
  attr_accessor :balance

#REAL start_date should be Date.today
  def initialize(start_date=Date.new(2019, 3, 21), credit_limit, apr)
    @start_date = start_date
    @credit_limit = credit_limit
    @apr = apr/100/365
    @balance = 0.0
    @history = {}
    @array = []
  end




  def charge_card(amount, date=Time.new(2019, 4, 20))
    if validate_float(amount) == false
      return "Error. Please only enter valid currency denominations. Example: 100.25"
# Screens out incorrectly formatted input  
    elsif @balance + amount <= @credit_limit
      @balance += amount
      @history[clean_date(date)] = {"Paid: $#{'%.2f' % amount}" => "Balance: $#{'%.2f' % @balance}"}
      @array << @history

      # @array << @history
      return "$#{'%.2f' % amount} charge accepted. Current balance is: $#{'%.2f' % @balance}. Remaining credit available: $#{'%.2f' % (@credit_limit - @balance)}." 
# '%.2f' formats the amount to display 2 decimal places, even if they're zeros.
  
    else
      return "Charge declined. Cannot exceed $#{@credit_limit}."
    end
  end





  def make_payment(payment, date=Time.now)
    @new_balance = @balance - payment
    if @new_balance == 0
      @balance = 0
      transaction_time = clean_date(date)
      @history[transaction_time] = {"Paid: $#{payment}" => "Balance: $#{'%.2f' % @new_balance}"}
      @array << @history
      return "You have paid off your credit card. Nothing owed."
    elsif @new_balance < 0
      return "Warning: This deposit will overpay your balance. Please pay a maximum of $#{'%.2f' % @balance} only." 
    else
      @balance = @new_balance
      @history[transaction_time] = {"Paid: $#{payment}" => "Balance: $#{'%.2f' % @new_balance}"}
      return "Thank you for your payment of $#{payment}. A balance of $#{'%.2f' % @new_balance} remains."
    end

  end

  def report_daily_balance(day)

    return 

  end


  def check_daily_interest
    @today = Date.today
    @account_lifespan = (@today - @start_date + 1).to_i 
  end
    
  def card_history
    puts @history.keys  

      # @array.each do |value|
      #  # value.each do |k,v|
      #   # puts "#{k}, #{v}"
      #   # end
      #   puts value
        # end 
   
  end


  def validate_float(input)
    return false unless input == input.to_f 
    return false unless input == input.round(2)
    true
  end  

  def clean_date(date)
    return date.strftime("%m/%d/%Y at %I:%M%p")
  end

end




a = Account.new(1000, 0.35)
# p a.credit_limit
# # p a.apr
# p a.start_date.strftime("%B %d, %Y")
# p a.check_balance
 a.charge_card(50)
 a.make_payment(30)
 a.charge_card(100.50)
 a.make_payment(150.5)
p a.card_history

