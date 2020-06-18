require 'rails_helper'

RSpec.describe "User", type: :system do
    let!(:user_a) {FactoryBot.create(:user)}
    let(:login_user) {user_a}
    before do
        visit contents_path
    end

    describe "content一覧ページのユーザー表示確認" do
        
    end
    
end