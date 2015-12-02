module MessagesHelper
  def query_type(q)
    if q.is_a?(Date)
      { created_at: q }
    else
      { body: q}
    end
  end
end