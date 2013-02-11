require 'spec_helper'

describe PetitionsController do
  let!(:petitions) { [FactoryGirl.create(:petition), FactoryGirl.create(:petition)] }
  let(:petition) { petitions.first }

  describe 'a GET to :index' do
    it 'assigns to @petitions ordered by most recent first' do
      get :index
      assigns(:petitions).should == petitions.reverse
    end
  end


  describe 'a GET to :show' do
    it 'assigns to @petition' do
      get :show, id: petition.id
      assigns(:petition).should == petition
    end
  end
end