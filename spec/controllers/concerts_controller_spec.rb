require 'rails_helper'

RSpec.describe ConcertsController, type: :controller do
  let(:concert) { FactoryBot.create(:concert) }
  let(:admin) { FactoryBot.create(:admin) }
  delegate :sign_in, to: 'controller.view_context'

  describe "GET index" do
    before do
      get :index
    end
    it "has a 200 status code." do
      expect(response.status).to eq(200)
    end
    it "assigns @title." do
      expect(assigns(:title)).to eq("コンサート一覧")
    end
    it "assigns @concerts." do
      expect(assigns(:concerts)).to eq([concert])
    end
    it "reders the index template." do
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    context "when concert id is exists" do
      before do
        get :show, id: concert.id
      end
      it "has a 200 status code." do
        expect(response.status).to eq(200)
      end
      it "assigns @title." do
        expect(assigns(:title)).to eq("コンサート詳細")
      end
      it "assigns @concert." do
        expect(assigns(:concert)).to eq(concert)
      end
      it "reders the show template." do
        expect(response).to render_template(:show)
      end
    end

    context "when concert id is not exists" do
      before do
        get :show, id: 100
      end
      it "redirect the index template." do
        expect(response).to redirect_to(concerts_index_path)
      end
      it "has a flash[:danger]." do
        expect(flash[:danger]).to eq("コンサート情報が存在しません。")
      end
    end
  end

  describe "GET new" do
    context "when you are signed in" do
      before do
        sign_in admin
        get :new
      end
      it "has a 200 status code." do
        expect(response.status).to eq(200)
      end
      it "assigns @title." do
        expect(assigns(:title)).to eq("コンサート新規登録")
      end
      it "assigns @url." do
        expect(assigns(:url)).to eq(concerts_create_path)
      end
      it "assigns @concert." do
        expect(assigns(:concert)).to be_a_new(Concert)
      end
      it "reders the new template." do
        expect(response).to render_template(:new)
      end
    end

    context "when you are not signed in" do
      before do
        get :new
      end
      it "has a 302 status code." do
        expect(response.status).to eq(302)
      end
    end
  end
end
