require 'rails_helper'
# bundle exec rspec spec/system/users_spec.rb

RSpec.describe 'ユーザ管理機能', type: :system do
  describe '登録機能' do
    context 'ログインせずに有給休暇取得状況一覧画面に遷移した場合' do # ok
      it 'ログイン画面に遷移し、「ログインしてください」というメッセージが表示される' do
        visit paid_leaves_path
        expect(page).to have_text 'ログインしてください。'
      end
    end
  end

  describe 'ログイン機能' do
    let!(:user) { FactoryBot.create(:user, :paid_leave) }
    context '登録済みのユーザでログインした場合' do
      it '有給休暇取得状況画面に遷移し、有給休暇取得状況一覧画面が表示される' do
        sign_in user
        visit paid_leaves_path
        expect(page).to have_text '有給休暇取得計画表（年間）'
      end

      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される' do
        sign_in user
        visit paid_leaves_path
        click_button 'ログアウト'
        expect(page).to have_text 'ログアウトしました。'
      end
    end
  end

  describe '管理者機能' do
    let!(:user) { FactoryBot.create(:user, :paid_leave, :grant ,:car) }
    let!(:second_user) { FactoryBot.create(:second_user, :paid_leave_second, :second_car) }
    context '管理者がログインした場合' do
      it '社員情報一覧画面にアクセスできる' do
        sign_in user
        visit paid_leaves_path
        click_on "社員情報一覧"
        expect(page).to have_text '社員情報一覧'
      end

      it 'ユーザ編集画面から、自分以外のユーザを編集できる' do
        sign_in user
        visit paid_leaves_path
        click_on "社員情報一覧"
        # binding.irb
        # find("a[href='/admin/users/#{edit_id}/edit']").click
        # sleep 0.5
        # expect(page).to have_text '社員情報一覧'
      end

      it 'ユーザを削除できる' do
        # sign_in user
        # visit paid_leaves_path
        # click_on "社員情報一覧"
        # first('a', text: '削除').click
        # expect(page).to have_text '社員情報の削除が完了しました'
      end
    end
  end
end