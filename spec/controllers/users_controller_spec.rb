require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  it "200レスポンスを返すこと" do
    get :show
    expect(response).to have_http_status "200"
  end
end
