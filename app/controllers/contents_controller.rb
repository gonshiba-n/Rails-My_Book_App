class ContentsController < ApplicationController

  before_action :set_contents, only: [:show, :edit, :update, :destroy]

  def index
		@q = current_user.contents.ransack(params[:q])
		@contents = @q.result(distinct: true).page(params[:page]).per(10)
    count = 0
    @count = count
  end

  def show
  end

  def edit
  end

  def new
    @content = Content.new
  end

  def create
    @content = current_user.contents.new(content_params)
    if @content.save
      redirect_to contents_url, notice: "タイトル「#{@content.name}」を投稿しました"
    else
      render :new
    end
  end

  def update
    @content.update!(content_params)
    redirect_to contents_url, notice: "タイトル「#{@content.name}」を更新しました"
  end

  def destroy
    @content.destroy
    redirect_to contents_url, notice: "タイトル「#{@content.name}」を削除しました"
  end

  def select_destroy
    if select_content_params.uniq.count == 1
      redirect_to contents_url, notice: "削除項目を選択してください"
    else
      select = []
      select_content_params.map{|n|
        select << n
        select.delete("0")
      }
        select.each{|id|
          content = Content.find(id)
          content.destroy
        }
      redirect_to contents_url, notice: "ブックマークを削除しました"
    end
  end


  private

  def content_params
    params.require(:content).permit(:name, :url, :description, :category, :private)
  end

  def select_content_params
        ids = params.require(:content).permit(content_ids: [])
        ids.values[0]
  end

  def set_contents
    @content = current_user.contents.find(params[:id])
  end

end
