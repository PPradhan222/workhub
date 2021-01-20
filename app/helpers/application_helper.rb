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

  def created_time_ago(task)
    creation_time = task.created_at.utc.to_i
    current_time = Time.now.utc.to_i
    min_hr_day_year_ago(current_time - creation_time)
  end

  def min_hr_day_year_ago(time_difference)
    case time_difference
      when (0..59)
        "just now"
      when (60..3599)
        pluralize_time(time_difference / 60, "minute")
      when (3600..86399)
        pluralize_time(time_difference / 3600, "hour")
      when (86400..31535999)
        pluralize_time(time_difference/ 86400, "day")
      else
        pluralize_time(time_difference/ 31536000, "year")
    end  
  end

  def pluralize_time(amount, measure)
    ActionController::Base.helpers.pluralize(amount, measure) + " ago"
  end

  def pluralize_task(amount)
    ActionController::Base.helpers.pluralize(amount, "task")
  end

  def available_actions(task)
    Task.statuses.keys.select {|action| action != task.status }
  end
end
