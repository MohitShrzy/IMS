class UserController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :find_items
  
  def sign_up
    @user=User.new
  end


  def create
    @user=User.new(user_params)
    if @user.save
      flash[:notice]="Registration Successful!!!"
      redirect_to home_path
    else
      flash[:notice]="Please give valid input!!!"
      render :sign_up
    end
  end


  def login
    if request.post?
      search_user=User.find_by_email(user_params[:email])
      current_user=user_params.clone
      if search_user != nil
        if search_user[:password]==current_user[:password].to_i
          session[:user]=search_user[:email]
          redirect_to user_home_path
        else      
          flash[:notice]="Wrong Passowrd"
        end

      else
      flash[:notice]="User not registered"
      end
    end
  end
                   
  def home
    @session=session[:user] 
  end
  def add_product
    @item=Item.all
    @session=session[:user]
    
    if params[:product].present?
      @item = Product.find(params[:product]).items
      
    else
      @item = Item.all
      
    end
    if request.xhr?
      respond_to do |format|
          format.json {
              render json: {item: @item}
          }
      end
    end
  end


  def user_order_history
    email=params[:session]
  
    @orders = Order.where(user_email: email)
    p @orders
    p"--------------------------find---------------"

    
  end

  def logout
    session[:user]=nil
    flash[:notice]="You Logout successfully"
    redirect_to root_path
  end

  # def find_items
  #   @found_item=Item.find(params[:id])
  # end

  private
  def user_params
    params.permit(:name, :email, :password)
  end

  
end
