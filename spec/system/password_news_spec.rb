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
end
