require 'rails_helper'

RSpec.describe "Sessions", type: :system do

  #before do
    #@user = FactoryBot.create(:user)
    #visit login_path
    #fill_in("メールアドレス", with: 'test@example.com')
    #fill_in("パスワード", with: "testtest")
    #click_on("ログイン")
    #expect(current_path).to eq "/users/#{@user.id}"
    #@current_user = @user
  #end

  #scenario "有効な情報を入力した時、ログインが成功すること" do
    #visit login_path
    #fill_in("メールアドレス", with: @user.email)
    #fill_in("パスワード", with: @user.password)
    #click_on("ログイン")
    #aggregate_failures do
      #expect(current_path). to eq "/users/#{@user.id}"
      #expect(page).to have_no_link("Log in")
      #expect(page).to have_link("Account")
    #end
    #click_on("Account")
    #expect(page).to have_link("Log out", href: logout_path)
    #expect(page).to have_link("My page", href: "/users/#{@user.id}")
  #end
end
