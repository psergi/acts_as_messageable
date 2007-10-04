class Conversation < ActiveRecord::Base
  attr_reader :originator, :original_message, :last_sender, :last_message, :users
  has_many :messages
  has_many :mails
  before_create :clean
  #looks like shit but isnt too bad
  #has_many :users, :through :messages, :source => :recipients, :uniq => true doesnt work due to recipients being a habtm association
  has_many :recipients, :class_name => 'User', :finder_sql => 
    'SELECT users.* FROM conversations 
    INNER JOIN messages ON conversations.id = messages.conversation_id 
    INNER JOIN messages_recipients ON messages_recipients.message_id = messages.id 
    INNER JOIN users ON messages_recipients.recipient_id = users.id
    WHERE conversations.id = #{self.id} GROUP BY users.id;'
  
  #originator of the conversation.
  def originator()
    @orignator = self.original_message.sender if @originator.nil?
    return @orignator
  end
  
  #first message of the conversation.
  def original_message()
    @original_message = self.messages.find(:first, :order => 'created_at') if @original_message.nil?
    return @original_message
  end
  
  #sender of the last message.
  def last_sender()
     @last_sender = self.last_message.sender if @last_sender.nil?
    return @last_sender
  end
  
  #last message in the conversation.
  def last_message()
    @last_message = self.messages.find(:first, :order => 'created_at DESC') if @last_message.nil?
    return @last_message
  end
  
  #all users involved in the conversation.
  def users()
    if(@users.nil?)
      @users = self.recipients.clone
      @users << self.originator unless @users.include?(self.originator) 
    end
    return @users
  end
  
  private
  def clean()
    return if(subject.nil?)
    #strip all illegal content here. (scripts, shit that will break layout, etc.)
  end
end
