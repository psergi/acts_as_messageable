class Message < ActiveRecord::Base
  serialize :headers
  
  class_inheritable_accessor :on_deliver_callback
  protected :on_deliver_callback
  
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :conversation
  has_and_belongs_to_many :recipients, :class_name => 'User', :join_table => 'messages_recipients', :association_foreign_key => 'recipient_id'
  
  def deliver(mailbox_type = :inbox, clean = true)
    self.clean() if clean
    self.recipients.each do |r|
      r.mailbox[mailbox_type] << self
    end
    self.on_deliver_callback.call(self, mailbox_type) unless self.on_deliver_callback.nil?
  end
  
  def clean()
    #strip all illegal content here. (scripts, shit that will break layout, etc.)
    self.save()
  end
  
  def Message.on_deliver(method)
    self.on_deliver_callback = method
  end
end
