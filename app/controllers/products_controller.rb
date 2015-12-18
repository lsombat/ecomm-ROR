class ProductsController < ApplicationController

def index 
  if current_user
     @products = Product.where("user_id=?",current_user.id)
   else
     redirect_to new_user_session_path, notice: 'You are not logged in.'
   end
end

def update
		  @product = Product.find(params[:id])
		  
		  if @product.update(product_params)
        redirect_to products_path
	    else
	      redirect_to products_path
	    end 
end

 private
 def product_params
   params.permit(:id,:promotion,:p_start,:p_end)
 end

end
