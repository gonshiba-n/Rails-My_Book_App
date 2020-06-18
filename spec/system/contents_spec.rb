require 'rails_helper'

RSpec.describe "Contents", type: :system do

    let(:user_a) {FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
    let(:user_b) {FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com', password: 'password_b')}
    let!(:content_a) {FactoryBot.create(:content, name: '最初のコンテンツ', url: "#{root_path}", user: user_a)}
    let!(:content_b) {FactoryBot.create(:content, name: '2のコンテンツ', url: '2のurl', user: user_a)}
    let!(:content_c) {FactoryBot.create(:content, name: '3のコンテンツ', url: '3のurl', user: user_a)}

    before do
        visit new_user_session_path
        fill_in 'アカウント名', with: login_user.name
        fill_in 'メールアドレス', with: login_user.email
        fill_in 'パスワード', with: login_user.password
        click_button 'Log in'
    end

    shared_examples_for 'ユーザーAが作成したコンテンツが表示されている' do
        it {expect(page).to have_content '最初のコンテンツ'}
    end

    describe "一覧要素表示検証" do
        let( :login_user ) { user_a }
        it "tablehead欄" do
            expect(page).to have_selector '.search-box'
            expect(page).to have_content '選択'
            expect(page).to have_content 'タイトル'
            expect(page).to have_content 'URL'
            expect(page).to have_content '概要'
            expect(page).to have_content 'カテゴリ'
            expect(page).to have_content '日時'
        end
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

    describe "検索機能" do
        let(:login_user) { user_a }
        before do
            # find('#search-box').click
            fill_in 'search-box', with: content_a.name
            find('#search-box').native.send_keys(:return)
        end

        it "検索した最初のコンテンツのみが表示されている" do
            expect(page).to have_content '最初のコンテンツ'
            expect(page).not_to have_content '2のコンテンツ'
            expect(page).not_to have_content '3のコンテンツ'
        end
    end

    describe "ページネーションの表示" do
        let(:login_user) { user_a }
        before do
            15.times {FactoryBot.create(:content, name: '最初のコンテンツ', url: '最初のurl', user: user_a)}
        end

        it "ページネーションが表示されていること" do
            expect(page).to have_selector '.paginate'
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
            it "何も削除されない" do
                expect(page).to have_selector '.alert-success', text: '削除項目を選択してください'
            end
        end
    end

    describe "詳細表示機能" do
        let( :login_user ) { user_a }

        before do
            visit content_path(content_a)
        end

        context "ユーザーAでログインしている時" do
            it_behaves_like 'ユーザーAが作成したコンテンツが表示されている'
        end

        describe "未入力欄の表示" do
            context "a context" do
                it "Noneになっていること" do
                    expect(page).to have_content 'None'
                end
            end
        end

        describe "削除機能" do
            before do
                find('.delete').click
                page.driver.browser.switch_to.alert.accept
            end
            it "正常に削除される" do
                expect(page).to have_selector '.alert-success', text: 'タイトル「最初のコンテンツ」を削除しました'
            end
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

