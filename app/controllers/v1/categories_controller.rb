module V1
  class CategoriesController < ApplicationController
    before_action :set_category, only: %i[show update destroy]

    resource_description do
      short 'Categories Actions'
      error code: 401, desc: 'Unauthorized'
      error code: 400, desc: 'Bad Request'
      error code: 404, desc: 'Not Found'
      error code: 422, desc: 'Unprocessable Entity'
      formats ['json']
    end

    def_param_group :base_category do
      property :id, :number, desc: 'Category id'
      property :description, String, desc: 'Category description'
      property :parent_category_id, :number, desc: 'Parent category id'
    end

    def_param_group :category do
      param_group :base_category
      property :parent_category, Hash do
        param_group :base_category
      end
      property :child_categories, Array do
        param_group :base_category
      end
    end

    api :GET, '/v1/categories', 'List all categories'
    returns array_of: :category, code: 200, desc: 'Successful response'
    def index
      categories = Category.where(user_id: current_user.id)

      render json: categories.map(&:to_response), status: :ok
    end

    api :GET, '/v1/categories/:id', 'Returns a category'
    param :id, :number, desc: 'Category id'
    returns code: 200, desc: 'Successful response' do
      param_group :category
    end
    def show
      render json: @category.to_response, status: :ok
    end

    api :POST, '/v1/categories', 'Creates a category'
    param :description, String, desc: 'Category description', required: true
    param(:parent_category_id, :number, required: false,
                                        desc: 'Parent category id',
                                        default_value: nil)
    returns code: 201, desc: 'Successful response' do
      param_group :category
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
    param :id, :number, desc: 'Category id'
    param :description, String, desc: 'Category description', required: true
    returns code: 200, desc: 'Successful response' do
      param_group :category
    end
    def update
      if @category.update(category_params)
        render json: @category.to_response, status: :ok
      else
        render error_response(:unprocessable_entity, @category.errors.messages)
      end
    end

    api :DELETE, '/v1/categories/:id', 'Delete a category'
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
