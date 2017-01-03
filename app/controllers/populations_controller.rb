class PopulationsController < ApplicationController
  def index
    @populations = Population.all
  end

  def show
    @population = Population.find(params[:id])
  end
end
