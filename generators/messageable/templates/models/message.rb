class Message < ActiveRecord::Base
  #any additional info that needs to be sent in a message (ex. I use these to determine request types)
  serialize :headers
  
  class_inheritable_accessor :on_deliver_callback
  protected :on_deliver_callback
  
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :conversation
  has_and_belongs_to_many :recipients, :class_name => 'User', :join_table => 'messages_recipients', :association_foreign_key => 'recipient_id'
  
  #delivers a message to the the given mailbox of all recipients, calls the on_deliver_callback if initialized.
  #
  #====params:
  #mailbox_type:: the mailbox to send the message to
  #clean:: calls the clean method if this is set (must be implemented)
  #
  def deliver(mailbox_type, clean = true)
    self.clean() if clean
    self.recipients.each do |r|
      r.mailbox[mailbox_type] << self
    end
    self.on_deliver_callback.call(self, mailbox_type) unless self.on_deliver_callback.nil?
  end
  
  #sets the on_deliver_callback to the passed method. The method call should expect 2 params (message, mailbox_type).
  def Message.on_deliver(method)
    self.on_deliver_callback = method
  end
  
  private
  
  def clean()
    #strip all illegal content here. (scripts, shit that will break layout, etc.)
    self.save()
  end
end
