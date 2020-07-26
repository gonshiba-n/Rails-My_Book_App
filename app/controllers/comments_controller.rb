class CommentsController < ApplicationController
    before_action :authenticate_user!
  def create
    content = Content.find(comment_params[:content_id])
    @comment = content.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "コメントしました"
      redirect_back(fallback_location: root_path)
      content.create_notification_comment!(current_user, @comment.id)
    elsif @comment.invalid?
      @comment.errors.full_messages.each do |message|
        @error_comment = message
      end
      flash[:notice] = @error_comment
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "コメントを削除しました"
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "コメントを削除できませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:comment, :content_id)
    end
end
