class CreateMail < ActiveRecord::Migration
  def self.up
    create_table :mail do |t|
      t.column :user_id, :integer, :null => false
      t.column :message_id, :integer, :null => false
      t.column :conversation_id, :integer
      t.column :read, :boolean, :default => false
      t.column :trashed, :boolean, :default => false
      t.column :mailbox, :string, :limit => 25
      t.column :created_at, :datetime, :null => false
    end
    #i use foreign keys but its a custom method, so i'm leaving it up to you want them.
  end

  def self.down
    drop_table :mail
  end
end
