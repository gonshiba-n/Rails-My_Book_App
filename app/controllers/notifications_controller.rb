class NotificationsController < ApplicationController
  def index
    # 相手からの通知のみ抽出
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)

    # 通知未確認(false)から確認(true)へデータ分、繰り返し変更
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end