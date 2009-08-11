class ApiController < ApplicationController
    
  before_filter :validate_api_key
  
  API_KEY = 'your_key_here' # can be moved to a spree preference
  
  
  def get_unshipped_orders
    @orders = Order.by_state('paid').find(:all, :conditions => ['downloaded_at IS NULL'], :include => [:line_items])
    
    respond_to do |format| 
      #format.html
      format.xml
    end
    
  end
  
  def mark_order_as_downloaded
    @order = Order.find_by_number(params[:id])
    @order.update_attribute(:downloaded_at, Time.now)
    
    render :text => 'true', :layout => false
    
  end
  
  def mark_order_as_shipped
  
    begin
      @order = Order.find_by_number(params[:number])
    
      shipment = @order.shipment
    
      shipment.tracking = params[:tracking]
      shipment.cost = params[:cost]
      shipment.shipped = "1"
      shipment.save
    
    
    
      render :text => "true", :layout => false
    rescue
      render :text => "error with request", :layout => false
    end
    
  end
  
  protected
  
  def validate_api_key
    unless API_KEY == params[:api_key]
      render :text => 'access denied'
    end
  end
  
  
end
