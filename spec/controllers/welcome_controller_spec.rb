require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET index" do
    it "has a 200 status code." do
      expect(response.status).to eq(200)
    end
  end
end
