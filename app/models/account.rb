require 'date'
class Account < ApplicationRecord
  validates :credit_limit, :apr, :balance, presence: true

  def check_balance
    # get the current balance
    # determine how many days the balance has been present
    # if date is <= 29 days from start then only the balance is reported
    #if date is >= 30 days from start then report balance + calculated interest (apr/365)

    daily_interest = @apr / 365).to_f


  end

end
