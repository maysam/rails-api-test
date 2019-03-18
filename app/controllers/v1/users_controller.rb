class V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :check_expired!, only: :show

  def index
    @users = User.all.page(params[:page]).per(10)
    json_response(@users)
  end

  def create
    @user = User.create!(user_params)
    json_response(@user, :created)
  end

  def show
    json_response(@user)
  end

  def update
    @user.update(user_params)
    head :no_content
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:name, :email, :date_of_birth,
      state_id_attributes: [:id, :number, :state, :expiration_date, :image, :remote_image_url, :_destroy],
      medical_recommendations_attributes: [
        :id, :number, :issuer, :state, :expiration_date, :image, :remote_image_url, :_destroy]
    )
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_expired!
    check_state_id_expired!
    check_medical_recommendation_expired!
  end

  def check_state_id_expired!
    return if @user.state_id.nil? || !@user.state_id.expired?

    raise Exceptions::StateIdExpired, 'State ID is expired'
  end

  def check_medical_recommendation_expired!
    return if @user.medical_recommendations.empty?
    # raise if at least one medical_recommendation is not expired
    return if @user.medical_recommendations.any? {|mr| !mr.expired?}

    raise Exceptions::MedicalRecommendationExpired, 'Medical Recommendation is expired'
  end
end
