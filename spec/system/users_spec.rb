require 'rails_helper'

RSpec.describe "Users", type: :system do

  before do
    @user = FactoryBot.create(:user)
    visit login_path
    fill_in("メールアドレス", with: @user.email)
    fill_in("パスワード", with: @user.password)
    click_on("ログイン")
    expect(current_path).to eq "/users/#{@user.id}"
    current_user = @user
  end

  describe "#ログイン状態" do

    context "main" do

      it "登録内容編集ページへ遷移すること" do
        visit "/users/#{@user.id}"
        click_on("登録内容を編集")
        expect(current_path).to eq "/users/#{@user.id}/edit"
      end

      it "登録内容を編集できること" do
        visit "/users/#{@user.id}/edit"
        fill_in("お名前", with: @user.name)
        fill_in("メールアドレス", with: @user.email)
        fill_in("パスワード", with: @user.password)
        fill_in("パスワード確認", with: @user.password)
        click_on("登録内容を変更する")
        expect(current_path).to eq "/users/#{@user.id}"
        expect(page).to have_content "編集しました"
      end

      it "BUTSUYOKU登録画面に遷移すること" do
        visit "/users/#{@user.id}"
        click_on("BUTSUYOKU登録!")
        expect(current_path).to eq new_item_path
      end

    end

    context "header" do

      it "BUTSUYOKUロゴからホーム画面に遷移すること" do
        click_on("BUTSUYOKU")
        expect(current_path).to eq root_path
      end

      it "aboutページに遷移すること" do
        click_on("What's BUTSUYOKU？")
        expect(current_path).to eq about_path
      end

      it "BUTSUYOKU一覧画面に遷移すること" do
        click_on("My BUTSUYOKU's")
        expect(current_path).to eq index_path
      end

      it "ユーザー詳細画面に遷移すること" do
        click_on("Account")
        click_on("My page")
        expect(current_path).to eq "/users/#{@user.id}"
      end

      it "ログアウトをクリックできること" do
        click_on("Account")
        click_on("Log out")
        aggregate_failures do
          expect(current_path).to eq root_path
          expect(page).to have_link "Log in", href: login_path
          expect(page).to have_no_link "My page"
        end
      end

    end

  end

end




# footerのQiitaリンクに遷移させるテストを書きたいが保留中。
