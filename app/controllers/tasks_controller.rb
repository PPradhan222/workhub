class TasksController < ApplicationController
  before_action :load_group, only: [:create]

  def create
    @task = @group.tasks.new(task_params)

    if @task.save
      UserTask.create(role: 'reporter', user_id: current_user.id, task_id: @task.id)
      UserTask.create(role: 'assignee', user_id: assigned_user.id, task_id: @task.id)
    end

    redirect_to @group
  end

  private

  def load_group
    @group = current_user.groups.find_by(id: params[:post][:group_id])
    redirect_to user_path(current_user), flash: { danger: 'Group is not present'} if @group.blank?
  end

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def assigned_user
    @group.users.find_by(id: params[:task][:assign_user])
  end
end
