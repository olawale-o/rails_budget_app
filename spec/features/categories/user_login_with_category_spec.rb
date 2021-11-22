require 'rails_helper'

RSpec.feature 'Category Index Page', type: :feature do
  login_user
  background do
    create(:category, user: @user, icon: Faker::LoremFlickr.image(size: '50x60', search_terms: ['fitness']))
    create(:category, user: @user, icon: Faker::LoremFlickr.image(size: '50x60', search_terms: ['sports']))
    @user.categories.first.treaties.create([{ name: 'Treaty 1', amount: 100, user: @user },
                                            { name: 'Treaty 2', amount: 100, user: @user }])
    visit(categories_path)
  end

  describe 'Category Index Page' do
    context 'when user is logged in' do
      scenario 'with categories i should see list of categories' do
        @user.categories.each do |category|
          expect(page).to have_content(category.name)
          expect(page).to have_content("$#{category.total_amount}")
        end
      end
      it 'should see add new link' do
        expect(find_link('ADD A NEW CATEGORY').visible?).to be true
        click_link('ADD A NEW CATEGORY')
        expect(page.current_path).to eq(new_category_path)
      end
    end
  end
end
