class MessageStatusChannel < ApplicationCable::Channel
  def subscribed
    key = params[:key]
    stream_from "message_status_#{key}"
  end

  def unsubscribed
    # Any cleanup needed when the channel is unsubscribed
  end
end
