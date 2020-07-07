class TimeLineController < ApplicationController
  def index
    @users = User.all
    @contents = Content.all.order(updated_at: :desc)
    @q = @contents.ransack(params[:q])
    @contents = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @content = Content.find(params[:id])
    @user = User.find(@content.user_id)
  end
end
