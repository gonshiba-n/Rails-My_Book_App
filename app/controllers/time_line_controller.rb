class TimeLineController < ApplicationController
  def index
    @users = User.all
    @contents = Content.where(private: [1, 2]).order(updated_at: :desc)
    @q = @contents.ransack(params[:q])
    @contents = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @content = Content.find(params[:id])
    @user = User.find(@content.user_id)
    if @content.private == 2
      unless @user.following?(current_user) || current_user.id == @content.user_id
        redirect_back(fallback_location: root_path)
      end
    elsif @content.private == 3
      unless @content.user_id == current_user.id
        redirect_back(fallback_location: root_path)
      end
    end
  end
end
