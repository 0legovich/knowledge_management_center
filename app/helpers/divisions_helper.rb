module DivisionsHelper
  def get_selected_organization(id)
    return nil if id.blank?
    Organization.find(id).id
  end
end
