require 'rails_helper'

RSpec.describe "コンテンツ管理機能", type: :system do

    let(:user_a) {FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
    let(:user_b) {FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com', password: 'password_b')}
    let!(:content_a) {FactoryBot.create(:content, name: '最初のコンテンツ', url: '最初のurl', user: user_a)}
    let!(:content_b) {FactoryBot.create(:content, name: '2のコンテンツ', url: '2のurl', user: user_a)}
    let!(:content_c) {FactoryBot.create(:content, name: '3のコンテンツ', url: '3のurl', user: user_a)}

    before do
        #ログイン画面へアクセス
        visit new_user_session_path
        #アカウント名を入力
        fill_in 'アカウント名', with: login_user.name
        #メールアドレスを入力
        fill_in 'メールアドレス', with: login_user.email
        #パスワードを入力
        fill_in 'パスワード', with: login_user.password
        #ログインボタンを押す
        click_button 'Log in'
    end

    shared_examples_for 'ユーザーAが作成したコンテンツが表示されている' do
        it {expect(page).to have_content '最初のコンテンツ'}
    end

    describe "一覧表示機能" do
        context "ユーザーAでログインしている時" do
            let( :login_user ) { user_a }

            it_behaves_like 'ユーザーAが作成したコンテンツが表示されている'
        end

        context "ユーザーBがログインしている時" do
            let( :login_user ) { user_b }

            it "ユーザーAのコンテンツが表示されない" do
                #作成済みコンテンツが画面上に表示されていることを確認
                expect(page).not_to have_content '最初のコンテンツ'
            end
        end
    end

    describe "選択削除機能" do
        let( :login_user ) { user_a }

        before do
            visit contents_path
            find('#select_delete_label1').click
            find('.delete').click
            page.driver.browser.switch_to.alert.accept
        end

        context "選択して削除した時" do
            before do
                find('#select_delete_label1').click
                find('.delete').click
                page.driver.browser.switch_to.alert.accept
            end

            it "正常に削除される" do
                expect(page).to have_selector '.alert-success', text: 'ブックマークを削除しました'
            end
        end

        context "選択せず削除ボタンを押した時" do
            before do
                find('.delete').click
                page.driver.browser.switch_to.alert.accept
            end
            it "正常に削除される" do
                expect(page).to have_selector '.alert-success', text: '削除項目を選択してください'
            end
        end
    end


    describe "詳細表示機能" do
        context "ユーザーAでログインしている時" do
            let( :login_user ) { user_a }

            before do
                visit content_path(content_a)
            end

            it_behaves_like 'ユーザーAが作成したコンテンツが表示されている'
        end
    end

    describe "新規作成機能" do
        let(:login_user) {user_a}

        before do
            visit new_content_path
            fill_in "タイトル",	with: content_name
            fill_in "URL", with: 'aaa'
            click_button '投稿する'
        end

        context "新規ブックマーク登録した時" do
            let(:content_name) {'新規ブックマークを作成'}

            it "正常に登録される" do
                expect(page).to have_selector '.alert-success', text: '新規ブックマークを作成'
            end
        end

        context "新規作成画面でタイトルを入力しなかった時" do
            let(:content_name) {''}

            it "エラーとなる" do
                within '.errors-val' do
                    expect(page).to have_content 'Nameを入力してください'
                end
            end
        end
    end
end

