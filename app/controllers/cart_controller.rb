class CartController < ApplicationController

  def save   
    @cart=Cart.new(cart_params)
    search_item=Item.find(cart_params[:item_id])
   
    if search_item.quantity.to_i<cart_params[:quantity].to_i
      flash[:alert]="Please order less Quantity"
      redirect_to user_home_path
    else

      if @cart.save 
      
        redirect_to cart_show_path(:cart_id=>@cart)
      else
        redirect_to user_home_path
    end
  end
  end

  def show
    @cart=Cart.find(params[:cart_id])
    @product=Product.find(@cart[:product_id])
    @item=Item.find(@cart[:item_id])
  end

  def checkout
    
    @cart=Cart.find(params[:checkout_id])
    @item=Item.find(@cart[:item_id])
    @amount_to_charge = @cart[:quantity]*@item[:price]
    @checkout_id=params[:checkout_id]
   
		if request.post?
      
		ActiveMerchant::Billing::Base.mode = :test
		# ActiveMerchant accepts all amounts as Integer values in cents
		#amount = 100
		credit_card = ActiveMerchant::Billing::CreditCard.new(
		:first_name         => params[:first_name],
		:last_name          => params[:last_name],
		:number             => params[:credit_no].to_i,
		:month              => params[:check][:month].to_i,
		:year               => params[:check][:year].to_i,
		:verification_value => params[:verification_number].to_i)

		# Validating the card automatically detects the card type
			gateway =ActiveMerchant::Billing::TrustCommerceGateway.new(
			:login => 'TestMerchant',
			:password =>'password',
			:test => 'true' )

			response = gateway.authorize(@amount_to_charge , credit_card)
			#response = gateway.purchase(amount_to_charge, credit_card)
      puts response.inspect
				if response.success?
				gateway.capture(@amount_to_charge, response.authorization)
        #UserNotifier.purchase_complete(session[:user],current_cart).deliver
        #flash[:notice]="Thank You for using Pink Flowers. The oreder details are sent to your mail"
        
        cart=Cart.find(params[:checkout_id])
        order=Hash.new
        order[:cart_id]=cart.id
        order[:user_email]=cart.user_email
        order[:product_id]=cart.product_id
        order[:item_id]=cart.item_id
        order[:quantity]=cart.quantity
        
        search_item=Item.find(order[:item_id])
        diff= search_item.quantity-order[:quantity].to_i
        update_quantity=Hash.new
        update_quantity[:quantity]=diff
        search_item.update(update_quantity)
        order=Order.new(order)
        order.save
        session[:cart_id]=nil
        
        redirect_to :action=>:purchase_complete
				else
        flash[:notice]= "Something went wrong.Try again"
				render :action => "checkout"
				end
      end
  end
  def purchase_complete
    
  end

  private
  def cart_params
    params.permit(:user_email, :product_id, :item_id, :quantity)
  end
end
