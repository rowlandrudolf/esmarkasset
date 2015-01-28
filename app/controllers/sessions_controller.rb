class SessionsController < ApplicationController

  def create
  	user = User.find_by(email: params[:email]) if params[:email]
  	if user && user.authenticate(params[:password])
  	  session[:user_id] = user.id 
  	  redirect_to user_redirect_path, notice: 'Welcome to Esmark Asset.'
    else
      redirect_to root_url, error: 'Invalid email / password'
    end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, notice: 'Goodbye.'
  end

private

  def user_redirect_path
    current_user.admin? ? dashboard_url : root_url 
  end

end
