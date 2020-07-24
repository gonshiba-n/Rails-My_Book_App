class RelationshipsController < ApplicationController
before_action :set_user

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:notice] = "#{@user.name}をフォローしました"
      @user.create_notification_follow!(current_user)
      redirect_back(fallback_location: root_path)
    else
      flash.now[:notice] = "#{@user.name}のフォローに失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:notice] = "#{@user.name}のフォローを解除しました"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:notice] = "#{@user.name}のフォロー解除に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
