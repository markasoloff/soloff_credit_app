require 'rspec'
require 'rubygems'
require 'active_support/time'
require_relative 'Soloff_account'

describe Account do
  it "stores the credit limit, apr, and inception date" do
    account = Account.new(35, 1000)
    expect(account.apr).to eq(35/100.0/365)
    expect(account.credit_limit).to eq(1000)            
    expect(account.inception_date).to be_within(2).of(DateTime.current)
  end
end

describe "Test Scenario 1" do
    it "returns balance of 514.38 after carrying a balance of 500 for 30 days after inception" do
    account = Account.new(35, 1000)
    expect(account.charge_card(500)).to eq(500)
    expect(account.total_outstanding_balance(30)).to eq(514.38)
  end
end

describe "Test Scenario 2" do
    it "30 days after inception, returns balance of 411.99 after these 
      transactions: 500 (inception), -200 (day 15), & 100 (day 25)" do
    account = Account.new(35, 1000)
    account.charge_card(500)
    account.pay_balance_time_machine(200)
    account.charge_card_time_machine(100)
    expect(account.total_outstanding_balance(30)).to eq(411.99)
  end
end

describe "#charge_card" do
  it "Return the sum after assigning it to the value of a hash." do
    account = Account.new(35, 1000)
    expect(account.charge_card(500)).to eq(500)
    expect(account.history[(DateTime.current).to_s] = 500)
  end
end

describe "#pay_balance" do
  it "Return the negative sum after assigning it to the value of a hash." do
    account = Account.new(35, 1000)
    expect(account.pay_balance(200)).to eq(-200)
    expect(account.history[(DateTime.current).to_s] = -200)
  end
end

describe "#validate_float" do
  it "rejects input that is not a float, rounded to 2 decimal places." do
    account = Account.new(35, 1000)
    expect(account.validate_float(2.00) == true)
    expect(account.validate_float(1) == false)
  end
end
