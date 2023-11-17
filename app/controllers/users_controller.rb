class UsersController < ApplicationController

    # GET /users/:username/:password
    def get_key
        @user = User.find_by(username: params[:username], password: params[:password])
        if @user.nil?
            render json: { error: 'User does not exist' }, status: :not_found
          else
            render json: { key: @user.key }
          end
    end

    # POST /users
    def create
        @user = User.new(user_params)
        @user.key = SecureRandom.uuid
        
        if @user.save
            render json: {key: @user.key}, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    # DELETE /users/:id
    def destroy
        @user = User.find(params[:id])
        @user.destroy
    end    

    private

    def user_params
    params.require(:user).permit(:username, :password)
    end
end
