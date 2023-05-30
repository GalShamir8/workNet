class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy like post_comments]
  before_action :set_post_comments, only: :show
  before_action :set_links, only: :index
  before_action :set_company_messages, only: :index

  # GET /posts or /posts.json
  def index
    @posts = fetch_posts
  end

  # GET /posts/1 or /posts/1.json
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))
    respond_to do |format|
      if @post.save
        Posts::CalculatePostRank.new(post: @post).call
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      attachments = post_params.delete(:attachments)
      if @post.update(post_params)
        attachments&.each do |attachment|
          @post.attachments.attach(attachment)
        end
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    if @post.likes.include?(current_user)
      @post.likes.delete(current_user)
    else
      @post.likes << current_user
    end
    redirect_back fallback_location: posts_path
  end

  def post_comments
    comment = @post.comments.build(post_comment_params.merge(user: current_user))
    if comment.save
      redirect_back fallback_location: post_path(@post), notice: 'comment was successfully updated.'
    else
      redirect_back fallback_location: post_path(@post), alert: comment.errors
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def set_links
    @links = Link.where(company: current_company)
  end

  def set_company_messages
    @company_messages = CompanyMessage.where(company: current_company)
  end

  def fetch_posts
    if params[:query].present?
      Meilisearch::SearchAdapterService.new(
        query: params[:query],
        model_name: 'Post',
        page: params[:page],
        per_page: params[:per_page]
      ).call
    else
      Post.user_posts(current_user).paginate(
        page: params[:page]
      )
    end
  end

  def set_post_comments
    @comments = @post.comments.paginate(page: params[:page])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:description, attachments: [])
  end

  def post_comment_params
    params.require(:comment).permit(:content)
  end
end
