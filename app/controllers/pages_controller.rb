class PagesController < ApplicationController

    before_action :authenticate_user!
    protect_from_forgery with: :exception

    def home
        
    end
    def dashboard
        @tickets = Ticket.all
        @clients = Client.all
        @sellers = Seller.all
        @products = Product.all
        @total_revenue = 0
        @tickets.each do |ticket|
            @total_revenue = @total_revenue + ticket.transaction_amount
        end
    end
        

end
