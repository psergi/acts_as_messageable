class CreateConversations < ActiveRecord::Migration
  def self.up
    create_table :conversations do |t|
      t.column :subject, :string, :default => ""
      t.column :created_at, :datetime, :null => false
    end
  end

  def self.down
    drop_table :conversations
  end
end
