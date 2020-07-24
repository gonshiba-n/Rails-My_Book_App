class FavoritesController < ApplicationController
  before_action :set_content

  def create
    content = current_user.like(@content)
    if content.save
      flash[:notice] = "#{@content.name}をお気に入り登録しました"
      @content.create_notification_favorite!(current_user)
      redirect_back(fallback_location: root_path)
    else
      flash.now[:notice] = "#{@content.name}のお気に入り登録に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    content = current_user.unlike(@content)
    if content.destroy
      flash[:notice] = "#{@content.name}のお気に入り登録を解除しました"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:notice] = "#{@content.name}のお気に入り登録解除に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_content
    @content = Content.find(params[:content_id])
  end
end
