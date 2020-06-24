require 'rails_helper'

RSpec.describe "PasswordNews", type: :system do

  before do
    visit new_user_password_path
  end

  it "パスワードの再設定画面の要素が表示されていること" do
    expect(page).to have_content 'パスワードの再設定'
    expect(page).to have_content 'メールアドレスを入力して「メールを送信」を押してしてください。'
    expect(page).to have_content 'パスワード再設定へのご案内をお送りします。'
    expect(page).to have_field 'メールアドレス'
    expect(page).to have_content "I'll send"
    expect(page).to have_content "you an email..."
    expect(page).to have_selector '.send-logo'
    expect(page).to have_button 'メールを送信'
  end

  describe "メールを送信する" do
    let!(:user_a) { FactoryBot.create(:user) }
    describe "再設定用のメールが届く" do

      it "ログインページへ遷移してメッセージを出力" do
        fill_in '#email', with: 'test1@example.com'
        click_button 'メールを送信'
        sleep 0.5
        expect(page).to have_content 'パスワードの再設定について数分以内にメールでご連絡いたします。'
      end
    end
  end
end
