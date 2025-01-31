class CompanyConstraint
  def matches?(request)
    Company.exists?(subdomain: request.subdomains.first)
  end
end
