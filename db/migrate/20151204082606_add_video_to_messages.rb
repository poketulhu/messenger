class AddVideoToMessages < ActiveRecord::Migration
  def up
    add_attachment :messages, :video
  end

  def down
    remove_attachment :messages, :video
  end
end
