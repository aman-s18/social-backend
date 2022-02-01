class Api::V1::UsersController < Api::ApiV1Controller
  before_action :set_user, only: %i[ update destroy add_social_account ]

  # GET /users
  # GET /users.json
  def index
    users = User.all
    json_success("Users fetched successfully!", users)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    user = User.find_by(username: params[:id])
    if user
      social_accounts = user.social_accounts.as_json(only: [:account_url, :logo_url])
      image = user.images.order(created_at: :desc).first.as_json(only: [:file_name])
      user_data = user.as_json(only: [:id, :email, :username, :phone, :about, :access_token]).merge!("social_accounts" => social_accounts, "image" => image)
      json_success("User fetched successfully!", user_data)
    else
      json_error("This account is not associated with us.", nil)
    end
  end

  # POST /users
  # POST /users.json
  def create
    user = User.new(user_params)
    user.generate_access_token
    if user.save
      json_success("Signup successfully!", user.as_json(only: [:id, :email, :username, :phone, :about, :access_token]))
    else
      json_error(user.errors.full_messages.to_sentence, nil)
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    
    binding.pry
    
    if @user.update(user_params)
      json_success("Account updated successfully!", @user)
    else
      json_error(@user.errors.full_messages.to_sentence, @user)
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.destroy
      json_success("Account deleted successfully!", @user)
    else
      json_error(@user.errors.full_messages.to_sentence, @user)
    end
  end

  def add_social_account
    if @user.update(user_params)
      json_success("Social accounts added successfully!", @user.social_accounts)
    else
      json_error(@user.errors.full_messages.to_sentence, @user)
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    user_id = params[:user_id] ? params[:user_id] : params[:id]
    @user = User.find_by_id(user_id)
    current_user = check_access_token(user_id, request.headers['Authorization'])
    json_error("Unautorized Access!", nil) unless @user && current_user
  end
  
  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :username, :phone, :about, :email_verified, :phone_verified, social_accounts_attributes: [ :id, :account_name, :account_url, :logo_url ])
  end
end
