class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :remove_subdomain_on_vacancy

  protected

  def remove_subdomain_on_vacancy
    url = root_url subdomain: 'www'
    redirect_to(url) if has_subdomain? && tenant.blank?
  end

  def tenant
    @tenant ||= find_tenant
  end
  helper_method :tenant

  def members
    tenant.present? ? tenant.members : []
  end
  helper_method :members

  def find_tenant
    Tenant.where(domain: request.subdomain).first
  end

  def has_subdomain?
    SubdomainConstraint.matches? request
  end

end
