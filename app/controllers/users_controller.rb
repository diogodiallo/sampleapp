class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @titre = @user.nom
    end
    
    def new
        @user = User.new
        @titre = "Inscription"
    end
    
    def create
        @user = User.new(params[:user])
        
        if @user.save
            sign_in @user
            #Affichage d'un message flash avant la rédirection
            flash[:success] = "Bienvenue #{@user.nom}"
            #redirection vers le profil membre
            redirect_to @user
        else
            @titre = "Inscription"
            render "new"
        end
    end
end