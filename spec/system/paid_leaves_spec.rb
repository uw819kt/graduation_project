require 'rails_helper'
# bundle exec rspec spec/system/paid_leaves_spec.rb

RSpec.describe '有給休暇一覧表示機能', type: :system do
  let!(:user) { FactoryBot.create(:user, :paid_leave, :approval) }
  let!(:second_user) { FactoryBot.create(:user, :paid_leave) }
  context '「有給休暇取得状況一覧」のリンクをクリックした場合' do
    it '正社員で勤続年数が6.5年以上の社員は20日で有給休暇付与日数が表示される' do
      sign_in user
      visit paid_leaves_path
      expect(page).to have_content "有給休暇取得計画表（年間）"
      expect(page).to have_content 20
    end

    it "パート社員で週3日かつ労働時間30時間未満で勤続年数が4.5年以上5.5年未満の社員は9日で有給休暇付与日数が表示される" do
      sign_in user
      visit paid_leaves_path
      expect(page).to have_content "有給休暇取得計画表（年間）"
      expect(page).to have_content 9
    end

    it '通常の有給適用の日数が月ごとに集計されて表示される' do
      sign_in user
      visit paid_leaves_path
      binding.irb
      num = [0, 0, 0, 0, 0, 0, 1] 
      page.all('tbody tr').each_with_index do |tr, idx|
        expect(tr.all("td")[14].text).to eq num[idx]
      end
    end
  end

  describe '詳細表示機能' do
    let!(:user) { FactoryBot.create(:user, :paid_leave, :approval) }
    context '「詳細」ボタンを押した場合' do
      it '通常の有給適用の数を差し引いた有給残日数が表示される' do
        sign_in user
        visit paid_leaves_path
        # click_on '詳細'
        # expect(page).to have_text 9
      end

      it '特別有給適用の日数は有給残日数にカウントされない' do
      # expect(page).to have_text 9
      end
    end
  end
end 