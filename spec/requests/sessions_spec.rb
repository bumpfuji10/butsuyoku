require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "request#destory" do
    before do
      @user = FactoryBot.create(:user)
      allow(User).to receive(:find_by).and_return(@user)
    end
  end
end
