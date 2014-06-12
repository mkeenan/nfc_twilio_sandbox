class UsersController < ApplicationController
  def index
  	@users = User.all
  	@user = User.create(content: "Banana")
  	text_updates(@user.content)

  end

  def new
  	@user = User.new
  end

 def create
  	@user = User.find(params[:user_id])
  	# @word = Word.find(params[:word_id])
    if @user.save
      redirect_to 'words/index'
      text_updates(@user.content)
    else
      render 'new'
    end
  end

  def text_updates(content)
    @content = content
    # @account_sid = ENV["TWILIO_ID"]
    # @auth_token = ENV["TWILIO_SECRET"]
        # set up a client to talk to the Twilio REST API 
        @client = Twilio::REST::Client.new ENV["TWILIO_ID"], ENV["TWILIO_SECRET"]  
        @client.account.messages.create({
          :from => ENV["TWILIO_PHONE"], 
          :to => "6518943894",
          :body => "#{@content}"
          })
    
   end
end