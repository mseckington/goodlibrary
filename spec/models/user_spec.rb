require 'spec_helper'

describe User do
  it 'has a factory that builds a valid instance' do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  describe 'validation' do
    let(:user) {
      User.new(
        :first_name => 'First name',
        :last_name => 'Last name',
        :email => 'alice@example.com',
        :password => 'password',
        :password_confirmation => 'password'
      )
    }

    it 'fails if first name is blank' do
      user.first_name = ''
      expect(user).not_to be_valid
    end

    it 'fails if first name is too long' do
      user.first_name = 'a' * 255
      expect(user).to be_valid
      user.first_name = 'a' * 256
      expect(user).not_to be_valid
    end

    it 'fails if last name is blank' do
      user.last_name = ''
      expect(user).not_to be_valid
    end

    it 'fails if last name is too long' do
      user.last_name = 'a' * 255
      expect(user).to be_valid
      user.last_name = 'a' * 256
      expect(user).not_to be_valid
    end

    it 'fails if email is blank' do
      user.email = ''
      expect(user).not_to be_valid
    end

    it 'fails if email is too long' do
      user.email = 'a' * (192 - '@example.com'.length) + '@example.com'
      expect(user).not_to be_valid
    end

    it 'fails if email is invalid' do
      user.email = 'john@doe'
      expect(user).not_to be_valid
    end

    it 'fails if email is not unique' do
      FactoryGirl.create(:user, :email => "alice@example.com")
      expect(user).not_to be_valid
    end

    it 'fails if password confirmation does not match password' do
      user.password = "one-two-three"
      user.password_confirmation = "two-one-four"
      expect(user).not_to be_valid
    end

    context 'on update' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        user.password = 'one-two-three'
        user.password_confirmation = 'one-two-three'
      end

      it 'fails if password confirmation is blank' do
        user.password_confirmation = '  '
        expect(user).not_to be_valid
      end

      it 'fails if passwords do not match' do
        user.password = "one-two-three"
        user.password_confirmation = "two-one-nine"
        expect(user).not_to be_valid
      end

      it 'fails if password confirmation is missing' do
        user.password_confirmation = nil
        expect(user).not_to be_valid
      end
    end
  end

  describe '.authenticate' do
    let(:email) { 'bob@example.com' }
    let(:password) { 'user-password' }

    it 'returns the user found by the email address and password' do
      user = FactoryGirl.create(:user, :email => email, password: password, password_confirmation: password)
      expect(User.authenticate(email, password)).to eq(user)
    end

    it 'returns nil if no user was found for the given email address' do
      FactoryGirl.create(:user, :email => email)
      expect(User.authenticate('john@example.com', password)).to be_nil
    end

    it 'returns nil if a user was found but the password was incorrect' do
      FactoryGirl.create(:user, :email => email, :password => password, :password_confirmation => password)
      expect(User.authenticate(email, 'incorrect-password')).to be_nil
    end
  end

  describe '#first_name' do
    let(:user) { User.new(first_name: 'Miss') }
    it 'returns the first name' do
      expect(user.first_name).to eq('Miss')
    end
  end

  describe '#last_name' do
    let(:user) { User.new(last_name: 'Geeky') }
    it 'returns the last name' do
      expect(user.last_name).to eq('Geeky')
    end
  end

  describe '#full_name' do
    let(:user) { User.new(first_name: 'Miss', last_name: 'Geeky') }
    it 'combines first_name and last_name' do
      expect(user.full_name).to eq('Miss Geeky')
    end
  end
end
