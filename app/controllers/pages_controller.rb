class PagesController < ApplicationController

    before_action :authenticate_user!
    protect_from_forgery with: :exception

    def home
        
    end
        

end
