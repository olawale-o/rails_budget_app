require 'rails_helper'

RSpec.feature 'Treaty New Page', type: :feature do
  login_user
  background do
    @treaty = create(:treaty, name: 'Taken', user: @user)
    @food = create(:category, name: 'Food', user: @user, icon: Faker::LoremFlickr.image(search_terms: ['clothes']))
    @garri = create(:category, name: 'Garri', user: @user, icon: Faker::LoremFlickr.image(search_terms: ['shoes']))
    visit(new_treaty_path)
  end

  describe 'Treaty new Page' do
    scenario 'with valid credentials' do
      within 'form' do
        fill_in 'treaty[name]', with: 'Treaty Feature'
        fill_in 'treaty[amount]', with: '10'
        select @food.name, from: 'treaty_category_ids'
        select @garri.name, from: 'treaty_category_ids'
      end
      click_button 'Add'
      expect(current_path).to eq category_path(@food.id)
      expect(page.has_content?('Treaty created successfully')).to be_truthy
    end
    scenario 'with invalid credentials' do
      within 'form' do
        fill_in 'treaty[name]', with: ''
        fill_in 'treaty[amount]', with: ''
      end
      click_button 'Add'
      expect(current_path).to eq treaties_path
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Amount can't be blank")
      expect(page).to have_content('Amount is not a number')
    end
    scenario 'with unique name' do
      within 'form' do
        fill_in 'treaty[name]', with: @treaty.name
        fill_in 'treaty[amount]', with: '10'
        select @food.name, from: 'treaty_category_ids'
      end
      click_button 'Add'
      expect(current_path).to eq treaties_path
      expect(page).to have_content('Name already taken by you')
    end
  end
end
