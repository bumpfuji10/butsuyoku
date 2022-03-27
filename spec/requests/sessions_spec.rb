require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "#new" do
    before do
      @user = FactoryBot.create(:user)
    end

    it "ログイン画面に正常にアクセス" do
      get login_path
      expect(response).to be_successful
    end

    it "200レスポンスを返す" do
      get login_path
      expect(response).to have_http_status "200"
    end
  end
end
