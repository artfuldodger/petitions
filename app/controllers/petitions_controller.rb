class PetitionsController < ApplicationController
  def index
    @petitions = Petition.order('id desc')
  end

  def show
    @petition = Petition.find(params[:id])
  end
end
