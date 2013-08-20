module ApplicationHelper
  def destroy_button(item)
    if current_user_admin?
      link_to 'Destroy', item,
              :method => :delete, :data => { :confirm => 'Are you sure?' },
              :class => "btn btn-danger"
    end
  end
end
