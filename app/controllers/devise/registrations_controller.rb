class Devise::RegistrationsController < DeviseController
  def new
    redirect_to new_user_session_path
  end
end
