class AddUnreadToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :unread, :integer
  end
end
