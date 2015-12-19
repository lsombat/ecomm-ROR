class AdminController < ApplicationController
	def index		  
		  if current_admin
		     @products = Product.all
		   else
		     redirect_to new_admin_session_path, notice: 'You are not logged in.'
		   end
  	end
  	def update
  	     @product = Product.find(params[:product][:id])
		  
		  if @product.update(product_params)
        redirect_to admin_index_path
	    else
	      redirect_to admin_index_path
	    end 
		 
  	end
  	
  	 private
    def product_params
      params[:product].permit(:id,:promotion,:p_start,:p_end)
    end
end
