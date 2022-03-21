require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe 'get index' do
    before do
      login_user user
    end
  end
end
