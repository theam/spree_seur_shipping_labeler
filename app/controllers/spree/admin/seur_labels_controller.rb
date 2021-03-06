module Spree
  module Admin
    class SeurLabelsController < Spree::Admin::BaseController
      require "base64"
      def show
        order = Spree::Order.where(number: params[:order_id]).first
        shipment = order.shipments.find_by(number: params[:id])

        if  SpreeSeurShippingLabeler::SeurConection.credentials[:seur_printer].blank?
          label = pdf_text(shipment.seur_label.print_label)        
          send_data(label, type: 'application/pdf', disposition: 'inline')
        else
          send_data(shipment.seur_label.print_label, filename: 'seur_label_' + shipment.number + '.txt')
        end
        
      end

      private

      def pdf_text string
        string.gsub!('\\r', "\r")
        string.gsub!('\\n', "\n")
        decode_base64_content = Base64.decode64(string.gsub("\n", ''))
      end
      
    end
  end
end