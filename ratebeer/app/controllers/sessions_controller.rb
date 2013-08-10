class SessionsController < ApplicationController
    def new
      # renderöi kirjautumissivun
    end

    def create
      user = User.where(:username => params[:username]).first
      if user.nil?
        redirect_to :back, :notice => "User #{params[:username]} does not exist!"
      else
        session[:user_id] = user.id
        redirect_to user_path(user), :notice => "Welcome back!"
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to :root
    end
end