class FeedsController < ApplicationController
  before_action :set_feed, only: %i[ show edit update destroy ]

  # GET /feeds or /feeds.json
  def index
    @feeds = Feed.all
  end

  # GET /feeds/1 or /feeds/1.json
  def show
    @feed = Feed.find_by(id: params[:id])
    # ↓今ログインしているユーザがそのブログをお気に入り登録しているかどうか」を判断
    @user = current_user.favorites.find_by(feed_id: @feed.id)
    @favorite = current_user.favorites.find_by(feed_id: @feed.id)
  end

  # GET /feeds/new
  def new
    @feed = current_user.feeds.build
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds or /feeds.json
  def create
    @feed = current_user.feeds.build(feed_params)
    # @feed = Feed.new(feed_params)
    # @feed.user_id = current_user.id #現在ログインしているuserのidを、feedのuser_idカラムに挿入する
    if params[:back]
      render :new
    else
      respond_to do |format|
        if @feed.save
          ContactMailer.contact_mailer(@feed.user).deliver
          format.html { redirect_to @feed, notice: "Feed was successfully created." }
          format.json { render :show, status: :created, location: @feed }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @feed.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def confirm
    @feed = Feed.new(feed_params)
    # @feed = current_user.feeds.build(feed_params)
    render :new if @feed.invalid?
  end

  # PATCH/PUT /feeds/1 or /feeds/1.json
  def update
    # updateメソッドの実行に失敗した場合はeditアクションをrenderするようにします。
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: "Feed was successfully updated." }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /feeds/1 or /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: "Feed was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feed_params
      params.require(:feed).permit(:image, :image_cache, :user_id, :content)
    end
end
