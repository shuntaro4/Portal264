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

  describe "GET show" do
    let(:concert) { FactoryBot.create(:concert) }
    context "when concert id is exists" do
      it "has a 200 status code." do
        get :show, id: concert.id
        expect(response.status).to eq(200)
      end
      it "assigns @title." do
        get :show, id: concert.id
        expect(assigns(:title)).to eq("コンサート詳細")
      end
      it "assigns @concert." do
        get :show, id: concert.id
        expect(assigns(:concert)).to eq(concert)
      end
      it "reders the show template." do
        get :show, id: concert.id
        expect(response).to render_template(:show)
      end
    end

    context "when concert id is not exists" do
      it "redirect the index template." do
        get :show, id: 100
        expect(response).to redirect_to(concerts_index_path)
      end
      it "has a flash[:danger]." do
        get :show, id: 100
        expect(flash[:danger]).to eq("コンサート情報が存在しません。")
      end
    end
  end
end
