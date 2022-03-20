require 'rails_helper'

RSpec.describe User, type: :model do

  it "Userモデルの有効なファクトリを持っているか" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  before do
    user = FactoryBot.build(:user)
  end

  it "名前、メールアドレス、パスワードがあれば有効" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "名前がなければ無効" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "メールアドレスがなければ無効" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "メールアドレスが重複していたら無効" do
    FactoryBot.create(:user)
    user = FactoryBot.build(:user)
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
end
