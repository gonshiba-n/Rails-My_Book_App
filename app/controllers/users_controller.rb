class UsersController < ApplicationController
  before_action :set_user

  def edit

  end

  def update
    if @user.update(user_params)
    redirect_to contents_url, notice: "ユーザープロファイルを更新しました"
    else
      @user.errors.full_messages.each do |m|
        redirect_to edit_user_path, notice: "#{m}"
      end
    end
  end

  private
  def set_user
    @user = current_user
  end

  def user_params
    params.require(:session).permit(:name, :introduction, :user_image)
  end

end
