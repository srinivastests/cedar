class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :require_login    

  def index
    @messages = Message.all
    @message = current_user.messages.build  
  end

  def show
  end

  def new
    @message = current_user.messages.build
  end

  def edit
  end

  def create
    @message = current_user.messages.build(message_params)

    respond_to do |format|
      if @message.save
        ActionCable.server.broadcast 'room_channel',
                                   content:  @message.content,
                                   username: @message.user.email
        format.html { redirect_back fallback_location: root_path, notice: 'Message was successfully created.' }
      else
        format.html { redirect_back fallback_location: root_path, notice: 'Message not created!' }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Message was successfully destroyed.' }
    end
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:content)
    end
end
