require 'rails_helper'

RSpec.describe "Items", type: :system do

  before do
    @user = FactoryBot.create(:user)
    visit login_path
    fill_in("メールアドレス", with: @user.email)
    fill_in("パスワード", with: @user.password)
    click_on("ログイン")
    expect(current_path).to eq "/users/#{@user.id}"
    current_user = @user
  end

  context "main" do

    before do
      @item = FactoryBot.create(:item)
      visit new_item_path
      fill_in("欲しいもの", with: @item.name)
      fill_in("金額", with: @item.price)
      select("2022", from: 'item[buy_month(1i)]')
      select("3", from: 'item[buy_month(2i)]')
      select("25", from: 'item[buy_month(3i)]')
      fill_in("買う理由", with: @item.reason)
      click_on("欲しい！")
    end

    it "BUTSUYOKU登録画面に遷移すること" do
      visit "/users/#{@user.id}"
      click_on("BUTSUYOKU登録!")
      expect(current_path).to eq new_item_path
    end

    it "BUTSUYOKUが登録できること" do
      expect(current_path).to eq index_path
    end

    #it "BUTSUYOKUを我慢（削除）すること" do
      #@item = FactoryBot.create(:item)
      #visit index_path
      #click_button("我慢する")
      #expect(current_path).to eq index_path
      #expect(page).to have_content "削除しました"
    #end

    it "BUTSUYOKUを我慢（削除）すること" do
      @item1 = Item.create(name: "TestProduct", price: 10000, buy_month: "2023-4-1", reason: "cause hoge!")
      @item2 = Item.create(name: "TestProduct", price: 20000, buy_month: "2023-5-1", reason: "cause hoge!")
      visit index_path
      click_button("我慢する")
      expect(current_path).to eq index_path
      expect(page).to have_content "削除しました"
      expect do
        @item1.destroy
      end.to change(Item, :count).by(-1)
    end
  end
end
