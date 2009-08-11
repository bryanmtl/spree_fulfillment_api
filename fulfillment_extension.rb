# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class FulfillmentExtension < Spree::Extension
  version "1.0"
  description "An extension that provides a generic XML feed that displays pending orders"
  url "http://github.com/bryanmtl/spree_fulfillment_api"

  # Please use fulfillment/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
    
    OrderMailer.class_eval do

      def order_has_shipped(order)
        @subject    = 'Guess what? Your order has shipped!'
        @body       = {"order" => order}
        @recipients = order.email
        @from       = Spree::Config[:order_from]
        @sent_on    = Time.now
        content_type "text/html"
      end

    end
    
  end
  
  
end