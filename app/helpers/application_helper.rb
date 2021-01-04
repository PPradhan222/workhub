module ApplicationHelper
  def flash_class(level)
    case level.to_sym
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :danger then "alert alert-danger"
        when :warning then "alert alert-warning"
    end
  end

  def assignable_users(group)
    group.users.map { |user| [user.name, user.id] }
  end
end
