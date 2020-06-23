require 'rails_helper'

RSpec.describe "User", type: :system do
    before do
        visit root_path
    end

    describe "サインインページ要素検証" do
        it "入力要素が表示されている" do
            expect(page).to have_selector 'h1.card-title', text: 'アカウント登録'
            expect(page).to have_field 'アカウント名'
            expect(page).to have_field 'メールアドレス'
            expect(page).to have_field 'パスワード'
            expect(page).to have_selector 'em', text: '(6 文字以上)'
            expect(page).to have_field '確認用パスワード'
            expect(page).to have_button 'Sign up'
            expect(page).to have_content '新規登録済みの方はこちら'
            expect(page).to have_link 'Login'
        end
    end

    describe "新規登録機能を検証" do
        it "正常に登録" do
            fill_in 'アカウント名', with: 'test_user'
            fill_in 'メールアドレス', with: 'test@test.com'
            fill_in 'パスワード', with: 'password'
            fill_in '確認用パスワード', with: 'password'
            click_button 'Sign up'

            @user = User.find_by(name: 'test_user')
            expect(current_path).to eq contents_path(@user.id)
        end

        it "登録不可" do
            fill_in 'アカウント名', with: ''
            fill_in 'メールアドレス', with: ''
            fill_in 'パスワード', with: 'pass'
            fill_in '確認用パスワード', with: 'hoge'
            click_button 'Sign up'

            expect(page).to have_content '名前を入力してください'
            expect(page).to have_content 'メールアドレスが入力されていません。'
            expect(page).to have_content '確認用パスワードとパスワードの入力が一致しません'
            expect(page).to have_content 'パスワードは6文字以上に設定して下さい。'
        end
    end

    describe "退会機能を検証" do
        before do
            fill_in 'アカウント名', with: 'test_user'
            fill_in 'メールアドレス', with: 'test@test.com'
            fill_in 'パスワード', with: 'password'
            fill_in '確認用パスワード', with: 'password'
            click_button 'Sign up'

            @user = User.find_by(name: 'test_user')
            if current_path == contents_path(@user.id)
                p '退会機能を検証中、サインアップ完了'
            else
                p '退会機能を検証中、サインアップできませんでした。'
            end

            visit edit_user_registration_path
            click_button 'アカウントの削除'
            page.driver.browser.switch_to.alert.accept
        end

        it "ユーザーのデータをDBから削除" do
            sleep 0.5
            expect(current_path).to eq new_user_session_path
            expect(User.where(email: 'test@test.com')).to be_empty
            expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
        end
    end
end
