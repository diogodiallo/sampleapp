class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    
    if user.nil?
        flash.now[:error] = "Combinaison eMail/Mot de passe invalide"
        @titre = "Connexion"
        render 'new'
    else
        sign_in user
        redirect_back_or user #redirection vers la page intentionnelle(friendly-redirect)
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
