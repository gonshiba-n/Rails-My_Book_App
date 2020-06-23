require 'rails_helper'

RSpec.describe Content, type: :model do
  let!(:content_a) { FactoryBot.create :content }

  describe "バリデーション" do
    it "有効な状態であること" do
      expect(content_a).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      content = build(:content, name: nil)
      content.valid?
      expect(content.errors[:name]).to include('を入力してください')
    end

    it "名前が35文字以内であること" do
      content = build(:content, name: "a" * 36)
      content.valid?
      expect(content.errors[:name]).to include('は35文字以内で入力してください')
    end

    it "URLがなければ無効な状態であること" do
      content = build(:content, url: nil)
      content.valid?
      expect(content.errors[:url]).to include('を入力してください')
    end

    it "URLはhttp(https):から始まらないと無効な状態であること" do
      content = build(:content, url: 'a')
      content.valid?
      expect(content.errors[:url]).to include('は不正な値です')
    end

    it "プライベートがなければ無効な状態であること" do
      content = build(:content, private: nil)
      content.valid?
      expect(content.errors[:private]).to include('を入力してください')
    end

    it "プライベートが0なら無効の状態になっている" do
      content = build(:content, private: 0)
      content.valid?
      expect(content.errors[:private]).to include('が不正な値です')
    end

    it "プライベートが4以上の数値なら無効の状態になっている" do
      content = build(:content, private: 4)
      content.valid?
      expect(content.errors[:private]).to include('が不正な値です')
    end

    it "プライベートの文字数が１文字であること" do
      content = build(:content, private: 10)
      content.valid?
      expect(content.errors[:private]).to include('は1文字以内で入力してください')
    end

    it "プライベートが数字以外なら無効の状態になっている" do
      content = build(:content, private: 'a')
      p content
      content.valid?
      expect(content.errors[:private]).to include('は数値で入力してください')
    end
  end
end
