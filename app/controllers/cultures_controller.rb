class CulturesController < ApplicationController
  def index
    @cultures = Culture.all
  end

  def show
    @culture = Culture.find(params[:id])
  end
end
