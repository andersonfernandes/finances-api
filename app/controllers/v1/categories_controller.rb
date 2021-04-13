module V1
  class CategoriesController < ApplicationController
    include Api::V1::Resource
    include Api::V1::Category::Request
    include Api::V1::Category::Response

    before_action :set_category, only: %i[show update destroy]

    api :GET, '/v1/categories', 'List all categories'
    header 'Authentication', 'User access token', required: true
    returns array_of: :category_response, code: 200, desc: 'Successful response'
    def index
      categories = Category.where(user_id: current_user.id)

      render json: categories.map(&:to_response), status: :ok
    end

    api :GET, '/v1/categories/:id', 'Returns a category'
    header 'Authentication', 'User access token', required: true
    param :id, :number, desc: 'Category id'
    returns code: 200, desc: 'Successful response' do
      param_group :category_response
    end
    def show
      render json: @category.to_response, status: :ok
    end

    api :POST, '/v1/categories', 'Creates a category'
    header 'Authentication', 'User access token', required: true
    param_group :create_category_request
    returns code: 201, desc: 'Successful response' do
      param_group :category_response
    end
    def create
      category = Category.new(category_params)

      if category.save
        render json: category.to_response, status: :created
      else
        render error_response(:unprocessable_entity, category.errors.messages)
      end
    end

    api :PUT, '/v1/categories/:id', 'Updates a category'
    header 'Authentication', 'User access token', required: true
    param_group :update_category_request
    returns code: 200, desc: 'Successful response' do
      param_group :category_response
    end
    def update
      if @category.update(category_params)
        render json: @category.to_response, status: :ok
      else
        render error_response(:unprocessable_entity, @category.errors.messages)
      end
    end

    api :DELETE, '/v1/categories/:id', 'Delete a category'
    header 'Authentication', 'User access token', required: true
    param :id, :number, desc: 'Category id'
    returns code: 204, desc: 'Successful response'
    def destroy
      if @category.destroy
        render json: {}, status: :no_content
      else
        render error_response(:unprocessable_entity, @category.errors.messages)
      end
    end

    private

    def category_params
      params
        .permit(:description, :parent_category_id)
        .merge(user_id: current_user.id)
    end

    def set_category
      @category = Category.find(params[:id])
    end
  end
end
