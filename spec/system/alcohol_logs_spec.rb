require 'rails_helper'
# bundle exec rspec spec/system/alcohol_logs_spec.rb

RSpec.describe 'アルコールチェック管理機能', type: :system do
  describe '登録機能' do
    let!(:user) { FactoryBot.create(:user, :car, :paid_leave) }
    context '酒気帯びチェックを登録した場合' do
      it '登録した内容が表示される' do
        sign_in user
        visit paid_leaves_path
        click_on '酒気帯びチェック表入力'
        select '前', from: 'alcohol_log_driving_status'
        select '電話', from: 'alcohol_log_confirmation'
        check 'alcohol_log_detector_used'
        fill_in '測定結果', with: 0.00
        select '良', from: 'alcohol_log_condition'
        fill_in '指示事項/その他', with: ""
        click_on '登録する'
        expect(page).to have_text '酒気帯び確認記録表（詳細）'
      end
    end
  end

  describe '編集機能' do
    let!(:user) { FactoryBot.create(:user, :car, :paid_leave) }
    let!(:alcohol_log1) { create(:alcohol_log, user_id: user.id, car: user.car) }
    let!(:alcohol_log2) { create(:alcohol_log2, user_id: user.id, car: user.car) }
    context '酒気帯びチェックを編集した場合' do
      it '編集した内容が表示される' do
        sign_in user
        visit paid_leaves_path
        click_on '酒気帯びチェック表一覧'
        visit alcohol_log_path(id: alcohol_log1.id) #詳細クリック
        click_on "編集"
        select '後', from: 'alcohol_log_driving_status'
        select '電話', from: 'alcohol_log_confirmation'
        check 'alcohol_log_detector_used'
        fill_in '測定結果', with: 0.00
        select '良', from: 'alcohol_log_condition'
        fill_in '指示事項/その他', with: ""
        click_on '更新する'
        expect(page).to have_text '良'
      end
    end
  end

  describe '一覧表示機能' do
    let!(:user) { FactoryBot.create(:user, :car, :paid_leave, :alcohol_log) }
    context '一覧画面に遷移した場合' do
      it '登録済みのアルコールチェック一覧が表示される' do
        sign_in user
        visit alcohol_logs_path
        click_on '酒気帯びチェック表一覧'
        expect(page).to have_content 0.01
      end
    end
  end
end
