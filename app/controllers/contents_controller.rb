class ContentsController < ApplicationController
  def index
    @contents = Content.all
  end

  def show
  end

  def edit
  end

  def new
    @content = Content.new
  end

  def create
    content = Content.new(content_params)
    content.save!
    redirect_to contents_url, notice: "タイトル「#{content.name}」を投稿しました"
  end


  private

  def content_params
    params.require(:content).permit(:name, :url, :description, :category, :private)
  end
end
