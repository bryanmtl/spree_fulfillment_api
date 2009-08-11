xml.instruct!
xml.orders do
  @orders.each do |order|
    xml.order do
      xml.number order.number
      xml.created_at order.updated_at
      xml.item_total order.item_total
      xml.line_items do
        order.line_items.each do |line_item|
          xml.line_item do
            begin
            xml.product line_item.product.name
            xml.sku line_item.variant.sku
            xml.product_variant variant_options_ybp(line_item.variant)
            xml.quantity line_item.quantity
          rescue
          end
          end
        end
      end
      xml.shipping_address do
        xml.name (order.ship_address.firstname + ' ' + order.ship_address.lastname)
        xml.address1 order.ship_address.address1
        xml.address2 order.ship_address.address2
        xml.city order.ship_address.city
        xml.state order.ship_address.state_text
        xml.zipcode order.ship_address.zipcode
        xml.country order.ship_address.country.name
        xml.phone order.ship_address.phone
      end
      xml.shipping_method do
        xml.name order.shipment.shipping_method.name rescue 'not specified'
      end
      xml.downloaded_url "http://#{Spree::Config[:site_url]}/api/mark_order_as_downloaded/" + order.number
      xml.callback_url "http://#{Spree::Config[:site_url]}/api/mark_order_as_shipped?number=" + order.number + "&tracking=&shipping_cost="
    end
  end
end
