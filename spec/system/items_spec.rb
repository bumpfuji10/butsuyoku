require 'rails_helper'

RSpec.describe "Items", type: :system do
  before do
    @item = FactoryBot.build(:item)
    @user = FactoryBot.create(:user)
  end

  describe "#home" do
    it "ホームページが描画されているか" do
      get root_path
      expect(response).to be_successful
    end
  end

  describe "#new" do
    it "BUTUSYOKU新規登録ページが描画されているか" do
      get new_item_path
      expect(response).to have_http_status "200"
    end
  end

  describe "#about" do
    it "aboutページが描画されているか" do
      get about_path
      expect(response).to have_http_status "200"
    end
  end

  describe "#show" do
    let(:user) { FactoryBot.create :user }
    it "showページが描画されているか" do
      get :show
      expect(response).to be_successful
    end
  end

end
