require 'rails_helper'

RSpec.describe ConcertsController, type: :controller do
  describe "GET index" do
    it "has a 200 status code." do
      get :index
      expect(response.status).to eq(200)
    end
    it "assigns @title." do
      get :index
      expect(assigns(:title)).to eq("コンサート一覧")
    end
    it "assigns @concerts." do
      concert = FactoryBot.create(:concert)
      get :index
      expect(assigns(:concerts)).to eq([concert])
    end
    it "reders the index template." do
      get :index
      expect(response).to render_template("index")
    end
  end
end
