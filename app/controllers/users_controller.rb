class UsersController < ApplicationController
  before_action :set_user

  def index
    @users = User.new
  end

  def show
    render :edit
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_contents_url(current_user), notice: "ユーザープロファイルを更新しました"
    else
      render :edit
    end
  end

  def other_user
    @other_user = User.find(params[:user_id])
    # @other_user_content = Content.where(user_id: params[:user_id])
    @q = @other_user.contents.ransack(params[:q])
    @other_user_content = @q.result(distinct: true).page(params[:page]).per(10).order(updated_at: :desc)
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:session).permit(:name, :introduction, :user_image)
  end
end
