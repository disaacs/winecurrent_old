class LcboController < ApplicationController
  
  # GET /lcbo/products/:product_id
  def product
    
    uri = URI('http://lcboapi.com/products/'+params[:product_id])
    req = Net::HTTP.get(uri)
    
    render json: req
    
  end
end
