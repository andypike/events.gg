class Queryable
  def count
    query.count
  end

  def empty?
    count == 0
  end

  def each(&block)
    query.find_each(&block)
  end

  def to_a
    query.to_a
  end

  def decorated
    query.decorate
  end
end