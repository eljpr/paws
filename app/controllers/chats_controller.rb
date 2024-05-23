class ChatsController < ApplicationController
  def index
    @chat = current_user.chats.first

    if @chat.nil?
      @chat = Chat.new
      @chat.user_id = current_user.id
      @chat.save!
    end

    @messages = Message.where(chat_id: @chat.id).order(created_at: :DESC)
  end

  def new
    @chat = current_user.chats.first
    @message = Message.new
    @message.chat = @chat
  end

  def show
    @chat = Chat.find(params[:id])
    @message = @chat.messages.last
  end
end
