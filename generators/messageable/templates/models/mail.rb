class Mail < ActiveRecord::Base
  self.table_name = "mail"
  belongs_to :message
  belongs_to :user
  belongs_to :conversation
  
  #sets the read attribute of the mail message to true.
  def mark_as_read()
    update_attribute('read', true)
  end
  
  #sets the read attribute of the mail message to false.
  def mark_as_unread()
    update_attribute('read', false)
  end
end
