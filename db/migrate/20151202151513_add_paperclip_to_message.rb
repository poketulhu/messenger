class AddPaperclipToMessage < ActiveRecord::Migration
  def up
    add_attachment :messages, :image
  end

  def down
    remove_attachment :messages, :image
  end
end
