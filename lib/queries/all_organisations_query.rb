class AllOrganisationsQuery < Queryable
  def initialize(relation = Organisation.all)
    @relation = relation
  end

  def query
    @relation.order("name ASC")
  end
end
