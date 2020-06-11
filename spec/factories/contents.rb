FactoryBot.define do
    factory :content do
        name{'テストを書く'}
        description{'Rspec&Copybara&Factorybotを準備する'}
        url{'http://test.test'}
        private{1}
        user
    end
end