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

  it "名前が50文字以上であれば無効" do
    @user.name = "a" * 51
    @user.valid?
    expect(@user).to be_invalid
  end

  it "メールアドレスがなければ無効" do
    @user.email = nil
    @user.valid?
    expect(@user.errors[:email]).to include("を入力してください")
  end

  it "パスワードがなければ無効" do
    @user.password = nil
    @user.valid?
    expect(@user.errors[:password]).to include("を入力してください")
  end

  it "パスワードが7文字以上であれば無効" do
    @user.password = "a" * 7
    @user.valid?
    expect(@user).to be_invalid
  end

  it "メールアドレスが正規表現でなければ有効" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to_not be_invalid
    end
  end

  it "メールアドレスが255文字以上であれば無効" do
    @user.email = "a" * 256
    expect(@user).to be_invalid
  end

end
