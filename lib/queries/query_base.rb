class QueryBase
  def count
    query.count
  end

  def find_each(&block)
    query.find_each(&block)
  end
end