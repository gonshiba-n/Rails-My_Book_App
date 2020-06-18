require 'rails_helper'

RSpec.describe "before_and_after_login", type: :system do
    let!(:user_a) {FactoryBot.create(:user)}
    let(:login_user) {user_a}

    describe "ログイン前後でnavの表示が変更されている" do
        before do
            visit new_user_session_path
        end

        context "ログイン前" do
            before do
                find(".navbar-toggler").click
            end

            it "新規登録、ログイン、About、お問い合わせになっていること" do
                expect(page).to have_link('新規登録')
                expect(page).to have_link('ログイン')
                expect(page).to have_link('About')
                expect(page).to have_link('お問い合わせ')
            end
        end

        context "ログイン後" do
            before do
                fill_in 'アカウント名', with: user_a.name
                fill_in 'メールアドレス', with: user_a.email
                fill_in 'パスワード', with: user_a.password
                click_button 'Log in'
                find(".navbar-toggler").click
            end

            it "ユーザー名、About、お問い合わせになっていること" do
                expect(page).to have_content("ログイン中: #{user_a.name}")
                expect(page).to have_link('ログアウト')
                expect(page).to have_link('About')
                expect(page).to have_link('お問い合わせ')
            end
        end
    end
end