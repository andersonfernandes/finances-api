module V1
  class CategoriesController < ApplicationController
    resource_description do
      short 'Categories Actions'
      error code: 401, desc: 'Unauthorized'
      error code: 400, desc: 'Bad Request'
      error code: 422, desc: 'Unprocessable Entity'
      formats ['json']
    end

    api :POST, '/v1/categories', 'Created a category'
    param :description, String, desc: 'Category description', required: true
    returns code: 201, desc: 'Successful response' do
      property :id, String, desc: 'Category id'
      property :description, String, desc: 'Category description'
    end
    def create
      category = Category.new(category_params)
      category.users << current_user

      if category.save
        render json: category_response(category), status: :created
      else
        render json: {
          message: 'Could not save the category',
          errors: category.errors.messages
        }, status: 422
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
