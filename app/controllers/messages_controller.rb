class MessagesController < ApplicationController
  def index
    @messages = current_user.messages
  end

  def create
    @chat = Chat.find(params[:chat_id])

    client = OpenAI::Client.new
    response = client.chat(parameters:
    {
      model: "gpt-3.5-turbo",
      messages:
      [{
        role: "user",
        content: message_params[:content]
      }]
    })

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.content = response["choices"][0]["message"]["content"]
    @message.question = message_params[:content]

    if @message.save!
      redirect_to chat_path(@chat, @message)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def message_params
    params.require(:message).permit(:content, :question)
  end
end
