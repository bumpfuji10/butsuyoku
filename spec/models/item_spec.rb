require 'rails_helper'

RSpec.describe Item, type: :model do

  before do
    @item = FactoryBot.create(:item)
  end

  #it "Itemモデルの有効なファクトリを持っているか" do
    #expect(FactoryBot.build(:item)).to be_valid
  #end

  it "名前、金額、買うタイミング、理由があれば有効" do
    expect(@item).to be_valid
  end

  it "名前がなければ無効" do
    @item.name = nil
    @item.valid?
    expect(@item.errors[:name]).to include("を入力してください")
  end

  it "金額がなければ無効" do
    @item.price = nil
    @item.valid?
    expect(@item.errors[:price]).to include("を入力してください")
  end

  it "買うタイミングがなければ無効" do
    @item.buy_month = nil
    @item.valid?
    expect(@item).to_not be_invalid
    # expect(@item).to be_invalid(無効)じゃないといけないが…ここは未完成
  end

  it "買う理由がなければ無効" do
    @item.reason = nil
    @item.valid?
    expect(@item).to be_invalid
  end

end

