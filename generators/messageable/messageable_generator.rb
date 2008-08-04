class MessageableGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      # Models
      m.file "models/conversation.rb", "app/models/conversation.rb"
      m.file "models/message.rb", "app/models/message.rb"
      m.file "models/mail.rb", "app/models/mail.rb"
      
      #Migrations
      generate_migrations(m,%w(
        create_conversations
        create_messages
        create_messages_recipients
        create_mail
      ))
      
      m.readme "INSTALL"
    end
  end
  
  def generate_migrations(recorder, names)
      names = names.is_a?(Array) ? names : [names]
      names.each do |n|
        recorder.migration_template "migrate/#{n}.rb", "db/migrate", :migration_file_name => n
      end
    end
end