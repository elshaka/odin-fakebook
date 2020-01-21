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
    user.save

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
end
