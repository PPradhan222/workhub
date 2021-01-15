class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    GroupChannel.broadcast_to message.group, {message: message, user: message.user}
  end
end
