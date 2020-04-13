# frozen_string_literal: true

class UsersController < ApplicationController
  authorize_resource

  # POST /users
  def create
    User.create!(user_params).then do |user|
      json_response user, :created
    end
  end

  # GET /users
  def index
    User.all.then do |result|
      result.page(page_permitted).then do |users|
        json_response users
      end
    end
  end

  # PUT /users/:id
  def update
    User.find(params[:id]).then do |user|
      user.update(user_params).then do |result|
        json_response result, :no_content
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :email, :name, :password,
                                 :role, :store_id)
  end
end
