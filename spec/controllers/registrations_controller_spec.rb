require 'spec_helper'

describe RegistrationsController do
  describe "new" do
    let(:user) {mock(:user)}

    before do
      User.stub(:new).and_return(user)
    end

    it 'assigns a new user' do
      get :new
      expect(assigns(:user)).to eql(user)
    end
  end

  describe "create" do
    let(:user) { stub_model(User, id: 'user-id', email: 'test@example.com') }
    let(:user_params) { {
      'first_name' => 'first-name',
      'last_name' => 'last-name',
      'email' => 'test@example.com',
      'password' => 'user-password',
      'password_confirmation' => 'user-password'
    } }

    before do
      User.stub(:create).and_return(user)
    end

    it "creates the user with the given details" do
      User.should_receive(:create).with(user_params).and_return(user)
      post :create, :user => user_params
      expect(assigns[:user]).to eq(user)
    end

    it 'rejects unsanitized parameters' do
      User.should_receive(:create).with(user_params).and_return(user)
      post :create, :user => user_params.merge('evil' => true)
    end

    context 'when the user is persisted' do
      before do
        user.stub(:persisted?).and_return(true)
      end

      # it "signs the user in" do
      #   post :create, :user => user_params
      #   expect(session['user_id']).to eq(user.id)
      # end

      it "redirects to the root page" do
        post :create, :user => user_params
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the user could not be created' do
      before do
        user.stub(:persisted?).and_return(false)
      end

      it "rerenders the new user form" do
        post :create, :user => user_params
        expect(response).to render_template(:new)
      end

      it "makes the unsaved user available to the view" do
        post :create, :user => user_params
        expect(assigns[:user]).to be_a User
      end

      it "makes the password confirmation available to the view" do
        user.password_confirmation = nil
        post :create, :user => user_params.merge(password_confirmation: 'password-confirmation')
        expect(assigns[:user].password_confirmation).to eq('password-confirmation')
      end
    end
  end


end
