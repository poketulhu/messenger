#bcrypt-ruby
=begin
users=[
  ["Sue L. Cole", 'd0SJuP'],
  ["William A. Adams", 'CyqMlm'],
  ["Joann K. Washington", 'hlZvY3'],
  ["Elizabeth J. Rayford", 'ALKeHs'],
  ["Marc L. Taylor", 'u9Qh8F']
]

users.each do |name, password|
  User.create(name: name, password: password, password_confirmation: password)
end
=end

=begin
Conversation.create(sender_id: 1, recipient_id: 2)
Conversation.create(sender_id: 2, recipient_id: 3)
Conversation.create(sender_id: 3, recipient_id: 4)

Message.create(body: "Hi", conversation_id: 1, user_id: 1)
Message.create(body: "Hi", conversation_id: 1, user_id: 2)
Message.create(body: "Hi", conversation_id: 1, user_id: 1)
Message.create(body: "Hi", conversation_id: 1, user_id: 2)
Message.create(body: "Hi", conversation_id: 1, user_id: 1)
Message.create(body: "Hi", conversation_id: 2, user_id: 2)
Message.create(body: "Hi", conversation_id: 2, user_id: 3)
Message.create(body: "Hi", conversation_id: 3, user_id: 3)
Message.create(body: "Hi", conversation_id: 3, user_id: 3)
=end

=begin
names=["Sue L. Cole", "William A. Adams", "Joann K. Washington", "Elizabeth J. Rayford", "Marc L. Taylor"]

names.each do |name|
  User.create(name: name)
end
=end