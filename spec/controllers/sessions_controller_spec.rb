require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET new" do
    before do
      get :new
    end
    it "has a 200 status code." do
      expect(response.status).to eq(200)
    end
    it "reders the new template." do
      expect(response).to render_template("new")
    end
  end
end