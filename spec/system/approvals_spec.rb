require 'rails_helper'
# bundle exec rspec spec/system/approvals_spec.rb

RSpec.describe '有給休暇登録管理機能', type: :system do
  describe '登録機能' do
    let!(:user) { FactoryBot.create(:user, :paid_leave) } 
    context '有給休暇申請の登録をした場合' do
      it '有給休暇管理表画面に戻る' do
        sign_in user
        visit paid_leaves_path
        click_on '有給休暇取得申請'
        fill_in '申請日時', with: '2024/10/05'
        fill_in '取得日', with: '2024/10/13'
        click_on '登録する'
        expect(page).to have_text '2025年度 年次有給休暇管理表'
      end
    end
  end

  describe '編集機能' do
    let!(:user) { FactoryBot.create(:user, :paid_leave, :approval) } 
    context '有給休暇申請の編集をした場合' do
      it '有給休暇管理表画面に戻る' do
        sign_in user
        visit paid_leaves_path
        page.all('.btn.btn-outline-primary')[1].click #詳細クリック
        click_on "編集" 
        fill_in '申請日時', with: '2024/10/05'
        fill_in '取得日', with: '2024/10/13'
        click_on '更新する'
        expect(page).to have_text '2025年度 年次有給休暇管理表'
      end
    end
  end
end