require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.create(:user)
  end

  it "Userモデルの有効なファクトリを持っているか" do
    expect(@user).to be_valid
  end

  it "名前、メールアドレス、パスワードがあれば有効" do
    expect(@user).to be_valid
  end

  it "名前がなければ無効" do
    @user.name = nil
    @user.valid?
    expect(@user.errors[:name]).to include("を入力してください")
  end

  it "メールアドレスがなければ無効" do
    @user.email = nil
    @user.valid?
    expect(@user.errors[:email]).to include("を入力してください")
  end

end
