class MessagesController < ApplicationController
  def create
    @group = current_user.groups.find_by(id: params[:message][:group_id])
    @body = params[:message][:body]

    @message = current_user.messages.create user: current_user,
                              group: @group,
                              body: params.dig(:message, :body)
  end

  private

    def message_params
      params.require(:message).permit(:body, :group_id)
    end
end
