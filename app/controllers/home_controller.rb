class HomeController < ApplicationController
  def index 
  if current_user
     @products = Product.where("promotion>0").where("p_end>=?",Time.now)
   else
     redirect_to new_user_session_path, notice: 'You are not logged in.'
   end
  end
  
  def show 
  if current_user
     @orders = Order.where("user_id=?",current_user.id)
     render 'index'
   else
     redirect_to new_user_session_path, notice: 'You are not logged in.'
   end
  end
  
  def buynow
  	     @product = Product.find(params[:id])
		  
		 if @product
		    @discount = @product.unitprice*(100-@product.promotion)/100
        if current_user.credits>= @discount
          @newOrder = Order.create({product_id:@product.id,user_id:current_user.id,price:@discount})
          @remaincredits = current_user.credits-@discount
          if current_user.update({credits:@remaincredits})
            @remainstock = @product.stock-1
          	@product.update({stock:@remainstock})
            redirect_to home_index_path
          else
            @newOrder.destroy()
            redirect_to home_index_path
          end
        else
          redirect_to home_index_path
        end 
	    else
	      redirect_to home_index_path
	    end 
		 
  	end

end
