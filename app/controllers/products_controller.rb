class ProductsController < ApplicationController

def index 
  if current_user
     @products = Product.where("user_id=?",current_user.id)
   else
     redirect_to new_user_session_path, notice: 'You are not logged in.'
   end
end

def create
      if current_user
		uploaded_io = params[:product][:image]
		@fname = current_user.id.to_s + Time.now.to_i.to_s+uploaded_io.original_filename
		params[:product][:image]=@fname
		params[:product][:user_id]=current_user.id
		File.open(Rails.root.join('public', 'images', @fname), 'wb') do |file|
		  file.write(uploaded_io.read)
		end
		
		@product = Product.create(newproduct_params)
		  
		 if @product
        redirect_to products_path, notice: 'DONE'
	    else
	      redirect_to products_path, notice: 'FAIL'
	    end 
	    
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
   params[:product].permit(:id,:promotion,:p_start,:p_end)
 end
 def newproduct_params
   params[:product].permit(:image,:user_id,:title,:description,:unitprice,:stock,:promotion,:p_start,:p_end)
 end

end
