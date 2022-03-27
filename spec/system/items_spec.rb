require 'rails_helper'

RSpec.describe "Items", type: :system do

  #homeは正しくログインがなされたかの確認で記述
  #about以降はusers_spec.rbで記述済み

  context "ログインしている場合" do

    before do
      @user = FactoryBot.create(:user)
      visit login_path
      fill_in("メールアドレス", with: @user.email)
      fill_in("パスワード", with: @user.password)
      click_on("ログイン")
      expect(current_path).to eq "/users/#{@user.id}"
      current_user = @user
      @item = FactoryBot.create(:item)
    end

    describe "#home" do
      it "homeへ遷移すること" do
        click_on("BUTSUYOKU")
        expect(current_path).to eq root_path
      end
    end

    describe "#new" do

      it "新規登録画面へ遷移されること" do
        visit root_path
        click_on("BUTSUYOKU登録！")
        expect(current_path).to eq new_item_path
      end

      it "新規登録をして一覧ページに遷移されること" do
        visit new_item_path
        fill_in("欲しいもの", with: @item.name)
        fill_in("金額", with: @item.price)
        select("2022", from: "item[buy_month(1i)]")
        select("4", from: "item[buy_month(2i)]")
        select("1", from: "item[buy_month(3i)]")
        fill_in("買う理由", with: @item.reason)
        click_on("欲しい！")
        aggregate_failures do
          expect(current_path).to eq index_path
          expect(page).to have_content "登録しました"
          expect(page).to have_content @item.name
          change(Item, :count).by(1)
          expect(page).to have_content "あなたのBUTSUYOKU合計金額は...#{@item.price.to_s(:delimited)}円です。"
        end
      end

    end

    describe "#edit" do

      it "編集に遷移できること" do
        @item = FactoryBot.build(:item)
        # createだと通らない⇨保存するのはNG？
        visit new_item_path
        fill_in("欲しいもの", with: @item.name)
        fill_in("金額", with: @item.price)
        select("2022", from: "item[buy_month(1i)]")
        select("4", from: "item[buy_month(2i)]")
        select("1", from: "item[buy_month(3i)]")
        fill_in("買う理由", with: @item.reason)
        click_on("欲しい！")
        click_button("編集する")
        expect(current_path).to eq "/items/#{@item.id}/edit"
      end

      it "BUTSUYOKUを編集できること" do
        visit "/items/#{@item.id}/edit"
        fill_in("欲しいもの", with: "Edited Product")
        fill_in("金額", with: 30000)
        select("2030", from: "item[buy_month(1i)]")
        select("5", from: "item[buy_month(2i)]")
        select("15", from: "item[buy_month(3i)]")
        fill_in("買う理由", with: "Cause hogehoge")
        click_on("変更する")
        aggregate_failures do
          expect(current_path).to eq index_path
          expect(page).to have_content "編集しました"
        end
      end

    end

    describe "#destroy" do

      it "BUTSUYOKUを削除できること" do
        @item = FactoryBot.create(:item)
        visit new_item_path
        fill_in("欲しいもの", with: @item.name)
        fill_in("金額", with: @item.price)
        select("2022", from: "item[buy_month(1i)]")
        select("4", from: "item[buy_month(2i)]")
        select("1", from: "item[buy_month(3i)]")
        fill_in("買う理由", with: @item.reason)
        click_on("欲しい！")
        click_button("我慢する")
        expect do
          expect(current_path).to eq index_path
          expect(page).to have_content "ナイスです！"
          change(Item, :count).by(1)
        end
      end

    end

  end

  context "ログインしていない場合" do

    describe "#new" do
      it "ログインしていない状態では登録画面へ遷移できないこと" do
        visit root_path
        visit new_item_path
        expect(current_path).to eq login_path
        expect(page).to have_content "ログインしてください"
      end
    end

    describe "#index" do

      it "ログインしていない状態では一覧画面へ遷移できないこと" do
        visit root_path
        visit index_path
        expect(current_path).to eq login_path
        expect(page).to have_content "ログインしてください"
      end

    end

    describe "#edit" do

      it "ログインしていない状態では編集画面へ遷移できないこと" do
        visit root_path
        visit "/items/12/edit"
        # 実際のidで検証
        expect(current_path).to eq login_path
        expect(page).to have_content "ログインしてください"
      end
    end

  end

end
