# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:new, :create, :show, :update]
  before_action :configure_sign_up_params, if: :devise_controller?

  # GET /resource/sign_up
  def new
  end

  def show
    super
  end

  # POST /resource
  def create
    super do
      resource.skip_confirmation!
      resource.save
    end
  end

  # GET /resource/edit
  def edit
    super do
      #resource.skip_reconfirmation!
      resource.save
    end
  end

  # PUT /resource
  def update
    super do
      #resource.skip_reconfirmation!
      resource.save
    end
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
