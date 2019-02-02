require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "should render the new template" do 
      get :new 
      expect(response).to render_template(:new)
    end  
  end 

  describe "POST #create" do
    context "with valid params" do
      before(:each) { post :create, params: { user: FactoryBot.attributes_for(:user) } }
      it "logs in the user" do
        expect(session[:session_token]).to eq(User.last.session_token)
      end

      it "redirects to user's show page" do
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context "with invalid params" do
      it "renders new template with errors" do
        post :create, params: { user: FactoryBot.attributes_for(:user, password: "") }
        expect(response).to render_template(:new)
        expect(flash[:errors]).not_to be_nil
      end
    end
  end

end
