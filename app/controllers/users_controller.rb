class UsersController < ApplicationController
    #Empêche un membre non connecté d'accéder au profil ou à modifier un autre profil
    before_filter :authenticate, :except => [:show, :new, :create]
    before_filter :correct_user, :only => [:index, :edit, :update]
    before_filter :admin_user,   :only => :destroy
    
    def index
        @users = User.paginate(:page => params[:page])
        @titre = "Utilisateurs"
    end
    
    
    def show
        @user = User.find(params[:id])
        @microposts = @user.microposts.paginate(:page => params[:page])
        @titre = "Profil de #{@user.nom}"
    end
    
    def new
        @user = User.new
        @titre = "Inscription"
    end
    
    
    def following
        @titre = "Following"
        @user = User.find(params[:id])
        @users = @user.following.paginate(:page => params[:page])
        render 'show_follow'
    end

    def followers
      @titre = "Followers"
      @user = User.find(params[:id])
      @users = @user.followers.paginate(:page => params[:page])
      render 'show_follow'
    end
    
    
    #Verbe POST : creation d'un nouvel utilisateur
    def create
        @user = User.new(users_params) #appel de la methode private users_params
        
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
    
    
    #Verbe Patch : edition d'un utilisateur
    
    def edit
        @user = User.find(params[:id])
        @titre = "Edition du profil de #{@user.nom}"
    end
    
    def update
        @user = User.find(params[:id])
        
        if @user.update(users_params)
            flash[:success] = "Profil actualisé"
            redirect_to @user
        else
            @titre = "Edition du profil"
            render 'edit'
        end
        
    end
    
    
    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "Utilisateur supprimé avec succès"
        redirect_to users_path
    end
    
    #Ceci est utiliser à la place de attr_accessible dans le model user
    private
        def users_params
           params.require(:user).permit(:nom, :email, :password, :password_confirmation) 
        end
        
        
        def relationships_params
            params.require(:relationship).permit(:followed_id)
        end
        
        
        #def authenticate
        #    deny_access unless signed_in?
        #end
        
        
        def correct_user
            @user = User.find(params[:id])
            redirect_to(root_path) unless current_user?(@user)
        end
        
        
        def admin_user
            redirect_to(root_path) unless current_user.admin?
        end
    
end