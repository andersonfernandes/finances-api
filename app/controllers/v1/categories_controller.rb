module V1
  class CategoriesController < ApplicationController
    resource_description do
      short 'Categories Actions'
      error code: 401, desc: 'Unauthorized'
      error code: 400, desc: 'Bad Request'
      error code: 422, desc: 'Unprocessable Entity'
      formats ['json']
    end

    def_param_group :category do
      property :id, String, desc: 'Category id'
      property :description, String, desc: 'Category description'
    end

    api :GET, '/v1/categories', 'List all categories'
    returns array_of: :category, code: 200, desc: 'Successful response'
    def index
      categories = Category
                   .joins(:users)
                   .where(categories_users: { user_id: current_user.id })
      categories_response = categories.map { |c| category_response(c) }

      render json: categories_response, status: :ok
    end

    api :POST, '/v1/categories', 'Creates a category'
    param :description, String, desc: 'Category description', required: true
    returns code: 201, desc: 'Successful response' do
      param_group :category
    end
    def create
      category = Category.new(category_params)
      category.users << current_user

      if category.save
        render json: category_response(category), status: :created
      else
        render error_response(:unprocessable_entity, category.errors.messages)
      end
    end

    private

    def category_params
      params.permit(:description)
    end

    def category_response(category)
      category.as_json(only: %i[id description])
    end
  end
end
