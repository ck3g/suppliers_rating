# TODO: display supplier status
# TODO: Display task "for"
# TODO: supplier stats (in work, queued, total)
# TODO: supplier details (name, contact, payment(wmz), total paid, rating, current tasks, queue tasks, completed)
class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

end
