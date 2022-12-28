class AdminController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def login
    if request.post?
      if params["username"]=="Admin" && params["password"]=="Admin"
        session[:admin]="Admin"
        redirect_to admin_home_path

      else 
        flash[:alert]="Invalid Username or Password"
        render "login"
      end
    end
  end
  def home
    @session=session[:admin]
  end 

  def logout
    session[:admin]=nil
    flash[:notice]="You Logout successfully"
    redirect_to root_path
  end

  def order_history
    @order=Order.all
  end
  
end
