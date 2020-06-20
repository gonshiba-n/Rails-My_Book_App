require 'rails_helper'

RSpec.describe "User", type: :system do
    let!(:user_a) {FactoryBot.create(:user)}
    let(:login_user) {user_a}

    before do
        visit new_user_session_path
        fill_in 'アカウント名', with: login_user.name
        fill_in 'メールアドレス', with: login_user.email
        fill_in 'パスワード', with: login_user.password
        click_button 'Log in'
    end

    describe "ユーザー情報編集要素" do
        let(:login_user) {user_a}

        before do
        visit edit_user_path(user_a.id)
        end
        context "ユーザー編集" do
            it "ユーザー情報編集要素の表示" do
                expect(page).to have_selector '.form-control-file'
                expect(page).to have_selector '.default_image'
                expect(page).to have_field 'user_name'
                expect(page).to have_field 'user_introduction'
                expect(page).to have_button '変更'
                expect(page).to have_selector '.delete'
                expect(page).to have_selector '.plus'
            end
        end
    end

    describe "ユーザー情報編集" do
        let(:login_user) {user_a}

        before do
        visit edit_user_path(user_a.id)
        end

        context "正常に編集された時" do
            before do
                fill_in "user_name", with: "user_b"
                fill_in "user_introduction", with: "よろしくお願いします"
                click_button '変更'
            end

            it "コンテンツ一覧ページにユーザー情報の変更が反映" do
                expect(current_path).to eq contents_path
                expect(page).to have_content 'user_b'
                expect(page).to have_content 'よろしくお願いします'
            end
        end

        context "変更不可" do
            before do
                fill_in "user_name", with: " "
                fill_in "user_introduction", with: 'あ' * 161
                click_button '変更'
            end
            it "コンテンツ一覧ページにユーザー情報の変更が反映されない" do
                expect(current_path).to eq "/users/#{user_a.id}"
                expect(page).to have_content '名前を入力してください'
                expect(page).to have_content 'ユーザープロフィールは160文字以内で入力してください'
            end
        end
    end

    describe "ユーザー詳細編集" do
        before do
            visit edit_user_registration_path(user_a.id)
        end
        describe "ユーザー詳細編集ページの要素表示" do
            it "ユーザー詳細編集ページの要素表示" do
                expect(page).to have_field 'メールアドレス'
                expect(page).to have_field 'パスワード'
                expect(page).to have_field '確認用パスワード'
                expect(page).to have_field '現在のパスワード'
                expect(page).to have_button '更新'
                expect(page).to have_button 'アカウントの削除'
            end
        end

        describe "ユーザー詳細編集機能" do
            context "正常にパスワードとメールアドレスが更新" do
                before do
                    fill_in "メールアドレス",	with: "b@b.com"
                    fill_in "パスワード",	with: "password_b"
                    fill_in "確認用パスワード",	with: "password_b"
                    fill_in "現在のパスワード",	with: "password"
                    click_button '更新'
                    if find(".navbar-toggler").click
                        click_link 'ログアウト'
                    else
                        click_link 'ログアウト'
                    end
                    visit new_user_session_path
                    fill_in 'アカウント名', with: login_user.name
                    fill_in 'メールアドレス', with: "b@b.com"
                    fill_in 'パスワード', with: "password_b"
                    click_button 'Log in'
                end
                it "正常に更新される" do
                    sleep 0.5
                    expect(current_path).to eq contents_path(user_a.id)
                end

                context "パスワードとメールアドレスが更新されない" do
                    before do
                        visit edit_user_registration_path(user_a.id)
                        fill_in "メールアドレス", with: " "
                        fill_in "パスワード", with: " "
                        fill_in "確認用パスワード",	with: " "
                        fill_in "現在のパスワード",	with: " "
                        click_button '更新'
                    end
                    it "更新されない" do
                        expect(current_path).to eq '/users'
                        expect(page).to have_content 'メールアドレスが入力されていません'
                        expect(page).to have_content '現在のパスワードを入力してください'
                    end
                end
            end
        end
    end
end