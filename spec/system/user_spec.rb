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

        context "ユーザー詳細編集" do
            before do
                visit '/users/edit'
            end

            it "ユーザー詳細編集ページの要素表示" do
                expect(page).to have_field 'メールアドレス'
                expect(page).to have_field 'パスワード'
                expect(page).to have_field '確認用パスワード'
                expect(page).to have_field '現在のパスワード'
                expect(page).to have_button '更新'
                expect(page).to have_button 'アカウントの削除'
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
                it "コンテンツ一覧ページにユーザー情報の変更が反映されない" do
                    
                end
                
            end
        end
        
    end
    
end