require 'spec_helper'

module Admin
  describe PetitionsController do
    let!(:petitions) { [FactoryGirl.create(:petition), FactoryGirl.create(:petition)] }
    let(:petition) { petitions.first }
    let(:admin) { FactoryGirl.create(:admin) }
    before { controller.stub(current_user: admin) }


    describe 'a GET to :index' do

      it 'assigns to @petitions ordered by most recent first' do
        get :index
        assigns(:petitions).should == petitions.reverse
      end
    end

    describe 'a GET to :new' do
      it 'assigns to @petition' do
        get :new
        assigns(:petition).should be_a_new Petition
      end
    end

    describe 'a POST to :create' do
      context 'when the petition is valid' do
        let(:action) { ->{ post :create, petition: { title: 'New Petition', description: '<p>Sign our petition, please.</p>' } } }

        it 'creates a petition' do
          expect {
            action.call
          }.to change(Petition, :count).by(1)
        end

        it 'associates the petition with the current user' do
          action.call
          Petition.last.user.should == admin
        end

        it 'redirects to the petition index' do
          action.call
          response.should redirect_to admin_petitions_url
        end

        it 'sets the flash' do
          action.call
          flash[:success].should == 'Petition successfully created.'
        end
      end

      context 'when the petition is invalid' do
        let(:action) { ->{ post :create, petition: {} } }

        it 'does not create a petition' do
          expect {
            action.call
          }.not_to change(Petition, :count)
        end

        it 'renders the new template' do
          action.call
          response.should render_template :new
        end
      end
    end

    describe 'a GET to :edit' do
      it 'assigns to @petition' do
        get :edit, id: petition.id
        assigns(:petition).should == petition
      end
    end

    describe 'a PUT to :update' do
      let(:action) { ->{ put :update, id: petition.id, petition: {} } }

      context 'when it successfully updates' do
        before { Petition.any_instance.stub(update_attributes: true) }
        it 'redirects to the petition index' do
          action.call
          response.should redirect_to admin_petitions_url
        end

        it 'sets the flash' do
          action.call
          flash[:success].should == 'Petition successfully updated.'
        end
      end

      context 'when it fails to update' do
        before { Petition.any_instance.stub(update_attributes: false) }

        it 'renders the edit template' do
          action.call
          response.should render_template :edit
        end
      end
    end

    describe 'a DELETE to :destroy' do
      let(:action) { -> { delete :destroy, id: petition.id } }

      it 'sets deleted_at on the petition' do
        petition.deleted_at.should be_nil
        Timecop.freeze(Time.now) do
          action.call
          petition.reload.deleted_at.should == Time.now
        end
      end

      it 'redirects to the petition index' do
        action.call
        response.should redirect_to admin_petitions_url
      end

      it 'sets the flash' do
        action.call
        flash[:success].should == 'Petition has been deleted.'
      end
    end
  end
end
