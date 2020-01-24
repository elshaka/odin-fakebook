require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }
  let(:another_user) { FactoryBot.build(:user) }

  it 'should validate the presence of a name' do
    user.name = nil
    user.validate

    expect(user.errors).to have_key(:name)
  end

  it 'should validate the presence of an email' do
    user.email = nil
    user.validate

    expect(user.errors).to have_key(:email)
  end

  it 'should check for a valid email address' do
    user.email = 'some Invalid @email'
    user.validate

    expect(user.errors).to have_key(:email)
  end

  it 'should downcase the provided email before saving' do
    email = Faker::Internet.email.upcase
    user.email = email
    user.validate

    expect(user.email).to eql(email.downcase)
  end

  it 'should validate email uniqueness' do
    user.save
    another_user.email = user.email
    another_user.validate

    expect(another_user.errors).to have_key(:email)
  end

  it 'should validate the presence of a valid password' do
    user.password = nil
    user.validate

    expect(user.errors).to have_key(:password)
  end

  it 'should validate the password confirmation matches' do
    user.password_confirmation = 'a non matching confirmation'
    user.validate

    expect(user.errors).to have_key(:password_confirmation)
  end

  it 'should set an image_url for a given email' do
    user.save

    expect(user.profile_image_url).to be_present
  end

  it 'should have a working has_many :posts relationship' do
    user.save
    10.times { user.posts.create FactoryBot.attributes_for :post }
    user.reload

    expect(user.posts.count).to eql(10)
  end

  describe '#friend?' do
    context 'when a user is not a friend of another user' do
      it 'should return false' do
        expect(user.friend? another_user).to be false
      end
    end

    context 'when a user is a friend of another user' do
      before { user.friends << another_user }

      it 'should return true' do
        expect(user.friend? another_user).to be true
      end
    end
  end

  describe '#friendship_request_sent?' do
    context 'when user has not sent a friend request' do
      it 'should return false' do
        expect(user.friendship_request_sent? another_user).to be false
      end

      context 'and the other user is the one who sent a friend request' do
        before do
          another_user.save
          another_user.friendships.create friend: user
        end

        it 'should return false' do
          expect(user.friendship_request_sent? another_user).to be false
        end
      end
    end

    context 'when user has sent a friend request' do
      before do
        user.save
        user.friendships.create friend: another_user
      end

      it 'should return true' do
        expect(user.friendship_request_sent? another_user).to be true
      end
    end
  end

  describe '#friendship_request_received?' do
    context 'when user has not received a friend request' do
      it 'should return false' do
        expect(user.friendship_request_received? another_user).to be false
      end

      context 'and the other user is the one who received the friend request' do
        before do
          user.save
          user.friendships.create friend: another_user
        end

        it 'should return false' do
          expect(user.friendship_request_received? another_user).to be false
        end
      end
    end

    context 'when the user has received a friend request' do
      before do
        another_user.save
        another_user.friendships.create friend: user
      end

      it 'should return true' do
        expect(user.friendship_request_received? another_user).to be true
      end
    end
  end
end
