class AddWalletColumnToAdventure < ActiveRecord::Migration
  def change
    remove_column :adventures, :wallet
    add_column :adventures, :wallet, :float, default: 0.0
  end
end
