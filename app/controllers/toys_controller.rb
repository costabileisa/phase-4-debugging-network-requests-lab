class ToysController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = Toy.find(params[:id])
    toy.update!(toy_params)
    render json: toy, status: :ok
  end

  def destroy
    toy = Toy.find(params[:id])
    toy.destroy
    head :no_content
  end

  private
  
  def toy_params
    params.permit(:id, :name, :image, :likes)
  end
  def render_not_found_response
    render json: { error: "not found" }, status: :not_found
  end

end
