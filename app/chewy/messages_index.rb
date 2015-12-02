class MessagesIndex < Chewy::Index
  # define_type Message do
  #   field :body, :user_id, :conversation_id
  # end

  settings analysis: {
    analyzer: {
      body: {
        tokenizer: 'standard',
        filter: ['lowercase', 'asciifolding']
      }
    }
  }

  define_type Message do
    field :body, analyzer: 'body'
    field :conversation_id, type: 'integer'
  end

end