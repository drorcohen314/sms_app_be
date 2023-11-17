require 'rubygems'
require 'twilio-ruby'
class MessagesController < ApplicationController
    before_action :set_message_by_id, only: [:show, :destroy, :update_message_status]

    # GET /messages/1
    def show
        render json: @message
    end

    # GET /messages/show_by_sender/:sender
    def show_by_sender
        @messages = Message.where(sender: params[:sender])
        render json: @messages
      end

    # POST /messages
    def create
        # To set up environmental variables, see http://twil.io/secure
        account_sid = ENV['TWILIO_ACCOUNT_SID']
        auth_token = ENV['TWILIO_AUTH_TOKEN']
        @sender = User.find_by(key: params[:key])
        if @sender
            client = Twilio::REST::Client.new(account_sid, auth_token)
            from = ENV['TWILIO_PHONE_NUMBER']
            to = message_params[:recipient]
            
            @message = Message.new(message_params)
            @message.sender = @sender.key
            max_id = Message.maximum(:id)
            if max_id.nil?
                @id = 1 
            else
                @id = max_id + 1
            end
            @callback_path = 'https://' + request.host.to_s + ':' + request.port.to_s + 'messages/update_status/' + @id.to_s
            message = client.messages.create(
            from: from,
            to: to,
            body: message_params[:content],
            status_callback: @callback_path)

            if @message.save
                render json: @message, status: :created
            else
                render json: @message.errors, status: :unprocessable_entity
            end
        else
            render json: { error: 'Sender or recipient not found' }, status: :not_found
        end    
    end

    def update_message_status
        if params[:MessageStatus].in?(%w[sent delivered]) || params[:SmsStatus].in?(%w[sent delivered])
            @message.update(sent: true)
            ActionCable.server.broadcast("message_status_#{@message.sender}", {id:@message.id, sent:@message.sent})
            render json: { message: 'Message status updated successfully' }, status: :ok
        else
            render json: { error: 'Invalid MessageStatus' }, status: :unprocessable_entity
        end
    end

    # DELETE /messages/1
    def destroy
        @message.destroy
    end

    private

    def set_message_by_id
    @message = Message.find(params[:id])
    end

    def message_params
    params.require(:message).permit(:recipient, :content, :sent)
    end
end
