class RegistrationsController < Devise::RegistrationsController

  def create
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          format.html { redirect_to session_path(@user), notice: 'User was successfully created. Please sign in' }
          format.json { render action: 'show', status: :created, location: @user }
        else
          format.html { render action: 'new' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  private
  def user_params
    params.require(:user).permit(:first_name,:last_name, :email, :password, :password_comfirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name,:last_name, :email,:password,:password_comfirmation,:current_password)
  end
  
end
