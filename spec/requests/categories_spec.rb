require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  login_user
  describe 'GET /index' do
    before(:each) do
      @food = create(:category, name: 'Food', user: @user)
      @garri = create(:category, name: 'Garri', user: @user, icon: Faker::Company.logo)
      @treaty1 = create(:treaty, name: 'Treaty1', user: @user)
      @treaty2 = create(:treaty, name: 'Treaty2', user: @user)
      @garri.treaties.push(@treaty1, @treaty2)
      get categories_path
    end

    it 'should return http status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'should render correct view' do
      assert_template 'categories/index'
    end

    it 'should include list of categories created by user' do
      expect(response.body).to include('Food')
      expect(response.body).to include('Garri')
      expect(response.body).to include("$#{@garri.treaties.sum(:amount)}")
    end
  end
end
