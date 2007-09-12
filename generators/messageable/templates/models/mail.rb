class Mail < ActiveRecord::Base
  self.table_name = "mail"
  belongs_to :message
  belongs_to :user
  belongs_to :conversation
  
  def mark_as_read()
    update_attribute('read', true)
  end
  def mark_as_unread()
    update_attribute('read', false)
  end
end
