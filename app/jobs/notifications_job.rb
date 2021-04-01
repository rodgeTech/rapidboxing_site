class NotificationsJob
  include SuckerPunch::Job

  def perform(type, user_id)
    OneSignalService.call(type, user_id)
  end
end
