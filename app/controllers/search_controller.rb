class SearchController < ApplicationController
  def index
    @q = User.where.not(id: current_user.id).ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(10)
    @contents = Content.where(private: [1, 2]).order(updated_at: :desc)
  end
end
