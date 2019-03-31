module V1
  class CategoriesController < ApplicationController
    before_action :set_category, only: %i[update destroy]

    resource_description do
      short 'Categories Actions'
      error code: 401, desc: 'Unauthorized'
      error code: 400, desc: 'Bad Request'
      error code: 404, desc: 'Not Found'
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

    api :PUT, '/v1/categories/:id', 'Updates a category'
    param :description, String, desc: 'Category description', required: true
    returns code: 200, desc: 'Successful response' do
      param_group :category
    end
    def update
      return render_user_category_error unless category_belongs_to_current_user

      if @category.update(category_params)
        render json: category_response(@category), status: :ok
      else
        render error_response(:unprocessable_entity, @category.errors.messages)
      end
    end

    api :DELETE, '/v1/categories/:id', 'Delete a category'
    returns code: 204, desc: 'Successful response'
    def destroy
      return render_user_category_error unless category_belongs_to_current_user

      if @category.destroy
        render json: {}, status: :no_content
      else
        render error_response(:unprocessable_entity, @category.errors.messages)
      end
    end

    private

    def category_params
      params.permit(:description)
    end

    def category_response(category)
      category.as_json(only: %i[id description])
    end

    def set_category
      @category = Category.find(params[:id])
    end

    def category_belongs_to_current_user
      @category.users.include?(current_user)
    end

    def render_user_category_error
      errors = { category_user: 'The user cannot update another user cateory' }
      render error_response(:unprocessable_entity, errors)
    end
  end
end
