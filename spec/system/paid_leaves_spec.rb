require 'rails_helper'
# bundle exec rspec spec/system/paid_leaves_spec.rb

RSpec.describe '有給休暇一覧表示機能', type: :system do
  context '「有給休暇取得状況一覧」のリンクをクリックした場合' do
    it '正社員で勤続年数が4.5年以上の社員は16日で有給休暇付与日数が表示される' do
    end

    it "パート社員で週3日かつ労働時間30時間未満で勤続年数が4.5年以上の社員は9日で有給休暇付与日数が表示される" do
    end

    it '通常の有給適用のチェックの数を差し引いた有給残日数が表示される' do
    end

    it '通常の有給適用の日数が月ごとに集計されて表示される' do
    end
  end
end 