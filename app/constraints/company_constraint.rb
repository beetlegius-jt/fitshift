class CompanyConstraint
  def matches?(request)
    Company.exists?(subdomain: request.subdomain)
  end
end
