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
Message.create(body: "Hi", conversation_id: 1, user_id: 1)
Message.create(body: "Hi", conversation_id: 1, user_id: 2)
Message.create(body: "Hi", conversation_id: 1, user_id: 1)
Message.create(body: "Hi", conversation_id: 1, user_id: 2)
Message.create(body: "Hi", conversation_id: 1, user_id: 1)
Message.create(body: "Hi", conversation_id: 1, user_id: 2)
Message.create(body: "Hi", conversation_id: 1, user_id: 1)
Message.create(body: "Hi", conversation_id: 1, user_id: 2)
Message.create(body: "Hi", conversation_id: 1, user_id: 1)
Message.create(body: "Hi", conversation_id: 1, user_id: 2)
Message.create(body: "Hi", conversation_id: 2, user_id: 3)
Message.create(body: "How are you?", conversation_id: 2, user_id: 3)
Message.create(body: "Hi", conversation_id: 2, user_id: 4)
=end

