class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.decimal :credit_limit, :precision => 1000, :scale => 2
      t.decimal :apr, :precision => 3, :scale => 2
      t.decimal :balance, :precision => 1000, :scale => 2

      t.timestamps
    end
  end
end
