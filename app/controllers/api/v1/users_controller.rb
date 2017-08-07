class Api::V1::UsersController < ApplicationController
  swagger_controller :users, "User Management"
  # before_action :set_user, only: [:show, :update, :destroy]



  # POST /api/v1/users
  swagger_api :create do
    summary "To create user"
    notes "Implementation notes, such as required params, example queries for apis are written here."
    param :form, "user[name]", :string, :required, "Name of user"
    param :form, "user[age]", :integer, :optional, "Age of user"
    param_list :form, "user[status]", :string, :required, "Status of user, can be active or inactive"
    response :success
    response :unprocessable_entity
    response 500, 'Internal error'
  end
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /api/v1/users/1
  # def update
  #   if @user.update(user_params)
  #     render json: @user
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /api/v1/users/1
  # def destroy
  #   @user.destroy
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_user
  #     @user = User.find(params[:id])
  #   end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.fetch(:user, {})
    end
end
