class MessagesIndex < Chewy::Index
  define_type Message do
    field :body
  end
end