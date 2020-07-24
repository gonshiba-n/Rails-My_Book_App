module NotificationsHelper
    def unchecked_notifications
        if user_signed_in?
            @notifications = current_user.passive_notifications.where(checked: false)
        end
    end
end
