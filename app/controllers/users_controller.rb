class UsersController < ApplicationController
  
  def index
    @user = User.all
  end
  
  def new
    redirect_to posts_path if user_logged?
    @user = User.new
  end
  
  def create
    role = Role.find_by(name: 'member')
    @user = role.users.new(user_params)
    if  @user.save()
      # UserMailer.registration_confirmation(@user).deliver_now
      flash[:success] = "Please confirm your email address to continue"
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      flash[:warning] = "Oooppss!, somthing went wrong"
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    @posts = Post.list_by_user(@user.id).published.paginate(page: params[:page], per_page: 10)
    @populare = Post.most_viewd
  end
  
  def draf
    @post = Post.post_draf.paginate(page: params[:page], per_page: 10)
  end
  
  def confirm_mail
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_active
      flash[:success] = "Welcome to RubyonRails App! Your email has been confirmed"
      redirect_to login_path
    else
      flash[:warning] = "Sorry, User does not exist"
      redirect_to root_path
    end
  end
  # def show
  #   @post = Post.find(params[:id])
  # end
  
  private 
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
    
end
