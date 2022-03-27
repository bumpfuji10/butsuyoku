require 'rails_helper'

RSpec.describe "Users", type: :system do

  context "ログインしている場合" do

    before do
      @user = FactoryBot.create(:user)
      visit login_path
      fill_in("メールアドレス", with: @user.email)
      fill_in("パスワード", with: @user.password)
      click_on("ログイン")
      expect(current_path).to eq "/users/#{@user.id}"
      current_user = @user
    end

    describe "#home" do

      it "homeページへ遷移すること" do
        click_on("BUTSUYOKU")
        expect(current_path).to eq root_path
      end

    end

    describe "#about" do

      it "aboutページへ遷移すること" do
        visit root_path
        click_on("What's BUTSUYOKU？")
        expect(current_path).to eq about_path
      end

    end

    describe "#edit" do

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

    end

    describe "#index" do

      it "BUTSUYOKU一覧画面に遷移できること" do
        visit "/users/#{@user.id}"
        click_on("My BUTSUYOKU's")
        expect(current_path).to eq index_path
      end

    end

    describe "#show" do

      it "ユーザー詳細画面に遷移できること" do
        click_on("Account")
        click_on("My page")
        expect(current_path).to eq "/users/#{@user.id}"
      end

    end

    describe "#destory" do

      it "ログアウトをクリックし、ログアウトが完了していること" do
        click_on("Account")
        click_on("Log out")
        aggregate_failures do
          expect(current_path).to eq root_path
          expect(page).to_not have_content "My BUTSUYOKU's"
          expect(page).to_not have_content "Account"
          expect(page).to have_content "Sign up"
          expect(page).to have_content "Log in"
        end
      end

    end

  end

  context "ログインしていない場合" do

    describe "#home" do
      it "homeへ遷移すること" do
        visit root_path
        click_on("BUTSUYOKU")
        expect(current_path).to eq root_path
      end
    end

    describe "#about" do

      it "aboutページへ遷移すること" do
        visit root_path
        click_on("What's BUTSUYOKU？")
        expect(current_path).to eq about_path
      end

    end

    describe "#edit" do

      it "ログインしていない状態では編集画面へ遷移できないこと" do
        visit "/users/1/edit"
        # 実際のidで検証
        expect(current_path).to eq login_path
        expect(page).to have_content "ログインしてください"
      end

    end

    describe "#show" do

      it "ログインしていない状態ではユーザー詳細画面へ遷移できないこと" do
        visit root_path
        visit "/users/2"
        # 実際のidで検証
        expect(current_path).to eq login_path
        expect(page).to have_content "ログインしてください"
      end
    end

  end

end
