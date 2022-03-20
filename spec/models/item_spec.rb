require 'rails_helper'

RSpec.describe Item, type: :model do

  it "Itemモデルの有効なファクトリを持っているか" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "名前、金額、買うタイミング、理由があれば有効" do
    item = FactoryBot.build(:item)
    expect(item).to be_valid
  end

  it "名前がなければ無効" do
    item = Item.new(name: nil)
    item.valid?
    expect(item.errors[:name]).to include("を入力してください")
  end
end
