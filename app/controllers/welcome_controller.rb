class WelcomeController < ApplicationController
  def index
     @products = Product.where("promotion>0").where("stock>0").where("p_end>=?",Time.now)
  end
end
