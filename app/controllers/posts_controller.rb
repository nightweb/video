class PostsController < ApplicationController
  
  # before_action :require_login, only: [:like, :dislike]
  
  def index
    @post = Post.published.paginate(page: params[:page], per_page: 10)
    @populare = Post.most_viewd
    # @pouplare = Post.populare
  end
  
  def new
    if user_logged?
      @post = Post.new
    else
      redirect_to login_path
    end
  end
  
  def create
    @post = current_user.posts.new(post_params)
    if  @post.save()
      flash[:success] = "Your video was submit succesfully"
      redirect_to @post
    else
      flash[:warning] = "Can not submit your video"
      render :new
    end
  end
  
  def draf
    role = current_user.role.name
    if role == 'admin'
      @post = Post.post_draf.paginate(page: params[:page], per_page: 10)
    else
      flash[:warning] = "You dont has permission"
    end
  end
  
  def most_viewed
    @post = Post.published.most_viewd.paginate(page: params[:page], per_page: 10)
    @most_liked = Post.most_liked
  end

  def show
    @post = Post.find(params[:id])
    @populare = Post.most_viewd
    @post.update_viewed
    
  end
  
  def published
    role = current_user.role.name
    if role == 'admin'
      post = Post.find(params[:id])
      if post.update_attribute(:status, 'published')
        flash[:success] = "Publish"
        redirect_to :back
      else
        flash[:warning] = "Some errors"
        redirect_to :back
      end
    else
      flash[:warning] = "You don't have permission"
      redirect_to :back
    end
  end
  
  def edit
    
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      redirect_to :back
    end
  end
  
  def destroy
    if permission?
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to :back
    else
      flash[:warning] = "You don't have permission"
      redirect_to :back
    end
  end
  
  #like action
  def like
    if user_logged?
      @post = Post.find(params[:id])
      like = Like.create(user_id: current_user.id, post_id: @post.id, like: true)
      if like.valid?
        @post.update_like(true)
      else
        
        check = Like.check_availiable(current_user.id, @post.id)
        if !check.like
          @post.update_like
          check.update_attribute(:like, true)
        end
      end
      respond_to do |format|
        format.json { render json: @post }
      end
    else
      @erorrs = {:message => 'hihie', :path => login_path}
      respond_to do |format|
        format.json { render json: @erorrs }
      end
    end
  end
  
  def dislike
    if user_logged?
      @post = Post.find(params[:id])
      like = Like.create(user_id: current_user.id, post_id: @post.id, like: true)
      if like.valid?
        @post.update_dislike(true)
      else
        check = Like.check_availiable(current_user.id, @post.id)
        if check.like
          @post.update_dislike
          check.update_attribute(:like, false)
        end
      end
      respond_to do |format|
        format.json { render json: @post }
      end
    else
      @erorrs = {:message => 'hihie', :path => login_path}
      respond_to do |format|
        format.json { render json: @erorrs }
      end
    end
  end
  
  def tags_ajax
    taglist = Tag.find_tag_like(params[:q])
    #abort(taglist.inspect)
    @tags_list = []
    if taglist
      taglist.each do |t|
        @tags_list.push(t.name)
      end
    end
    respond_to do |format|
      format.json { render json: @tags_list }
    end
  end
  
  private 
    def post_params
      params.require(:post).permit(:title, :video_id, :description, :tag_list)
    end
    # Require Login User for like and dislike function
    
    def require_login
      redirect_to login_path if !user_logged?
    end
    
end
