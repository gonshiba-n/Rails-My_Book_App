class ContentsController < ApplicationController
  def index
    @contents = Content.all
    count = 0
    @count = count
  end

  def show
    @content = Content.find(params[:id])
  end

  def edit
    @content = Content.find(params[:id])
  end

  def new
    @content = Content.new
  end

  def create
    content = Content.new(content_params)
    content.save!
    redirect_to contents_url, notice: "タイトル「#{content.name}」を投稿しました"
  end

  def update
    content = Content.find(params[:id])
    content.update!(content_params)
    redirect_to contents_url, notice: "タイトル「#{content.name}」を更新しました"
  end

  def destroy
    content = Content.find(params[:id])
    content.destroy
    redirect_to contents_url, notice: "タイトル「#{content.name}」を削除しました"
  end

  def select_destroy
    select_content_params.each{|id|
      content = Content.find(id)
      content.destroy
    }
    redirect_to contents_path, notice: "ブックマークを削除しました"
  end


  private

  def content_params
    params.require(:content).permit(:name, :url, :description, :category, :private)
  end

  def select_content_params
    ids = params.require(:content).permit(content_ids: [])
    ids.values[0]
  end

end
