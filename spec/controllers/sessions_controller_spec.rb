require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  let(:user) { FactoryGirl.create(:user) }

  describe "POST 'create'" do
    context 'when user is authenticated' do
      let(:action) { -> { post 'create', { username: user.username, password: 'password' } } }

      it "sets the user id in the session" do
        session[:user_id].should be_nil
        action.call
        session[:user_id].should == user.id
      end

      it 'redirects to admin_petitions_url' do
        action.call
        response.should redirect_to admin_petitions_url
      end

      it 'sets the flash' do
        action.call
        flash[:success].should == "Logged in!"
      end
    end

    context 'when authentication fails' do
      let(:action) { -> { post 'create', { username: user.username, password: 'incorrect-password' } } }

      it 'renders the new template' do
        action.call
        response.should render_template 'new'
      end

      it 'does not set the user id in the session' do
        action.call
        session[:user_id].should be_nil
      end
    end
  end

  describe "DELETE 'destroy'" do
    let(:action) { -> { delete 'destroy', { id: user.id } } }

    it "nils out session user id" do
      session[:user_id] = user.id
      action.call
      session[:user_id].should be_nil
    end

    it "redirects to root_url" do
      action.call
      response.should redirect_to root_url
    end

    it "sets the flash" do
      action.call
      flash[:success].should == 'Logged out.'
    end
  end

end
