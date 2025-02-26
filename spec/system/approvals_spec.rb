require 'rails_helper'
# bundle exec rspec spec/system/approvals_spec.rb

RSpec.describe '有給休暇登録管理機能', type: :system do
  describe '登録機能' do
    let!(:user) { FactoryBot.create(:user) } 
    context '有給休暇申請の登録をした場合' do
      it '登録した有給休暇申請の一覧が表示される' do
        sign_in user
        visit paid_leaves_path
        click_on '有給休暇取得申請'
        fill_in '申請日時', with: '2024/10/05'
        fill_in '取得日', with: '2024/10/13'
        click_on '登録する'
        expect(page).to have_text '有給休暇取得計画表（年間）'
      end
    end
  end

  describe '編集機能' do
    let!(:user) { FactoryBot.create(:user) } 
    context '有給休暇申請の編集をした場合' do
      it '登録した有給休暇申請の一覧が表示される' do
        sign_in user
        visit paid_leaves_path
        click_on '編集'
        fill_in '申請日時', with: '2024/10/05'
        fill_in '取得日', with: '2024/10/13'
        click_on '更新する'
        expect(page).to have_text '有給休暇取得計画表（年間）'
      end
    end
  end
end