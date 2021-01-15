class GroupsController < ApplicationController
  before_action :load_group, only: [:info, :show, :edit, :destroy]

  def new
    @group = Group.new
    @member_ship = MemberShip.new
  end

  def info
    @member_ship = current_user.member_ships.find_by(group_id: params[:id])
    @users = User.invitable(@group.invited_user_ids)
    @current_members = @group.users
  end

  def show
    @posts = @group.posts.order(created_at: :desc)
    @messages = @group.messages
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      @member_ship = MemberShip.create(group_id: @group.id, user_id: current_user.id, role: User::ROLES[:admin])
      redirect_to current_user
    else
      render 'new'
    end
  end

  def edit    
  end

  def update
  end

  def destroy
    @group.destroy

    redirect_to user_path(current_user)
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def load_group
    @group = current_user.groups.find_by(id: params[:id])
    redirect_to user_path(current_user), flash: { danger: 'Group is not present'} if @group.blank?
  end
end
