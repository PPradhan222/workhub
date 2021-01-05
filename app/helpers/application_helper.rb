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

  def assigned_user(task)
    task.user_tasks.find_by(role: 'assignee').user.name
  end

  def task_reporter(task)
    task.user_tasks.find_by(role: 'reporter').user.name
  end
end
