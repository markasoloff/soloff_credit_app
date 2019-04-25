require 'date'
require 'minitest/autorun'
require_relative 'cctracker'

class AccountTest < Minitest::Test
 def test_scenario_1
   account = Account.new(35, 1000)
   account.add_charge(500, account.open_date)
   assert_equal 514.38, account.check_balance(30)
 end

 def test_scenario_2
   account = Account.new(35, 1000)
   account.add_charge(500, account.open_date)
   account.add_payment(200, account.open_date + 15)
   account.add_charge(100, account.open_date + 25)
   account.current_balance
   assert_equal 411.99, account.check_balance(30)

 end

 def test_create_account
   account = Account.new(35, 1000)
   assert_equal 0.0009589041095890411, account.apr
   assert_equal 1000, account.credit_limit
   assert_equal Date.today, account.open_date
 end

 def test_add_charge
   account = Account.new(35, 1000)
   account.add_charge(500, account.open_date)
   assert_equal 500, account.transactions[account.open_date.to_s]
 end

 def test_add_payment
   account = Account.new(35, 1000)
   account.add_payment(500, account.open_date)
   assert_equal -500, account.transactions[account.open_date.to_s]
 end

 def test_over_limit_add_charge
   account = Account.new(35, 1000)
   assert_raises (ArgumentError) { account.add_charge(1001, account.open_date) }
 end
end







