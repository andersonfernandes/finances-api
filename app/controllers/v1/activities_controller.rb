module V1
  class ActivitiesController < ApplicationController
    include Api::V1::Resource
    include Api::V1::Activity::Request
    include Api::V1::Activity::Response

    before_action :set_activity, only: %i[show update destroy]

    api :GET, '/v1/activities', 'List all activities'
    header 'Authentication', 'User access token', required: true
    returns array_of: :activity_response, code: 200, desc: 'Successful response'
    def index
      activities = all_activities

      render json: activities.map(&:to_response), status: :ok
    end

    api :GET, '/v1/activities/:id', 'Returns a activity'
    header 'Authentication', 'User access token', required: true
    param :id, :number, desc: 'Activity id'
    returns code: 200, desc: 'Successful response' do
      param_group :activity_response
    end
    def show
      render json: @activity.to_response, status: :ok
    end

    api :POST, '/v1/activities', 'Creates a activity'
    header 'Authentication', 'User access token', required: true
    param_group :create_activity_request
    returns code: 201, desc: 'Successful response' do
      param_group :activity_response
    end
    def create
      activity = Activity.new(activity_params)

      if activity.save
        render json: activity.to_response, status: :created
      else
        render error_response(:unprocessable_entity, activity.errors.messages)
      end
    end

    api :PUT, '/v1/activities/:id', 'Updates a activity'
    header 'Authentication', 'User access token', required: true
    param_group :update_activity_request
    returns code: 200, desc: 'Successful response' do
      param_group :activity_response
    end
    def update
      if @activity.update(activity_params)
        render json: @activity.to_response, status: :ok
      else
        render error_response(:unprocessable_entity, @activity.errors.messages)
      end
    end

    api :DELETE, '/v1/activities/:id', 'Delete a activity'
    header 'Authentication', 'User access token', required: true
    param :id, :number, desc: 'Activity id'
    returns code: 204, desc: 'Successful response'
    def destroy
      if @activity.destroy
        render json: {}, status: :no_content
      else
        render error_response(:unprocessable_entity, @activity.errors.messages)
      end
    end

    private

    def activity_params
      permitted_params = %i[
        description amount paid_at recurrent expires_at
        category_id origin
      ]
      params.permit(permitted_params).merge(user_id: current_user.id)
    end

    def set_activity
      @activity = Activity.find(params[:id])
    end

    def all_activities
      Activity
        .includes(category: %i[child_categories parent_category])
        .where(user_id: current_user.id)
    end
  end
end
