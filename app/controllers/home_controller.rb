require 'mailgun'

class HomeController < ApplicationController
    def index
    end
    def write
        @title = params[:title]
        @address = params[:address]
        @content = params[:content]
        # https://github.com/jorgemanrubia/mailgun_rails 참고!
        mg_client = Mailgun::Client.new("key-ebeb2777dd295dd4035c792432b53a72")
        message_params =  {
                          from: 'takfeb@gmail.com',
                          to:   @address,
                          subject: @title,
                          text:    @content
                          }
        result = mg_client.send_message('sandbox32184d1a9f10475c832491878331a89f.mailgun.org', message_params).to_h!
        message_id = result['id']
        message = result['message']
        new_post = Post.new
        new_post.title = @title
        new_post.content = @content
        new_post.email = @address
        new_post.save
        redirect_to '/list'
    end
    
    def list
        @every_post = Post.all #Post.all.order("id desc") 최신순
    end
    
    def destroy
        @one_post = Post.find(params[:post_id])
        @one_post.destroy
        redirect_to "/list"
    end
    
    def update_view
        @one_post = Post.find(params[:post_id])
    end
    
    def siljae
        @one_post = Post.find(params[:post_id])
        @one_post.title = params[:title]
        @one_post.content = params[:content]
        @one_post.email = params[:address] 
        @one_post.save
        redirect_to "/list"
    end
    
    
    
end

