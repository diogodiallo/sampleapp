class PagesController < ApplicationController
    def home
        @titre = "Home"
    end
    
    def about
        @titre = "A propos"
    end
        
    def contact
        @titre = "Contact"
    end
    
    def help
        @titre ="Aide"
    end
end