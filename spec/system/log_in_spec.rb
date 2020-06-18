require 'rails_helper'

RSpec.describe "User", type: :system do
    let!(:user_a) {FactoryBot.create(:user)}
    let(:login_user) {user_a}
    before do
        visit new_user_session_path
    end

    describe "ログインページ要素検証" do
        it "ログインページ表示要素検証" do
            expect(page).to have_selector 'h2', text: 'ログイン'
            expect(page).to have_field 'アカウント名'
            expect(page).to have_field 'メールアドレス'
            expect(page).to have_field 'パスワード'
            expect(page).to have_content '次回から自動的にログイン'
            expect(page).to have_button 'Log in'
        end
    end

    describe "ログイン機能を検証" do
        before do
            visit new_user_session_path
        end
        it "正常にログイン" do
            fill_in 'アカウント名', with: user_a.name
            fill_in 'メールアドレス', with: user_a.email
            fill_in 'パスワード', with: user_a.password
            click_button 'Log in'

            @user = User.find_by(name: user_a.name)
            expect(current_path).to eq contents_path(@user.id)
            expect(page).to have_selector '.alert-success', text: 'ログインしました。'
            expect(page).to have_content user_a.name
        end

        it "ログイン不可" do
            fill_in 'アカウント名', with: ''
            fill_in 'メールアドレス', with: ''
            fill_in 'パスワード', with: 'pass'
            click_button 'Log in'

            expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
        end
    end

    describe "ログアウト機能を検証" do
        before do
            fill_in 'アカウント名', with: login_user.name
            fill_in 'メールアドレス', with: login_user.email
            fill_in 'パスワード', with: login_user.password
            click_button 'Log in'
        end

        it "正常にログアウト" do
            if find(".navbar-toggler").click
                click_link 'ログアウト'
            else
                click_link 'ログアウト'
            end
            expect(page).to have_content 'ログアウトしました。'
            expect(current_path).to eq new_user_session_path
        end
    end
end