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

  describe "GET edit" do
    context "when you are signed in" do
      before do
        sign_in admin
      end
      context "when concert id is exists" do
        before do
          get :edit, id: concert.id
        end
        it "has a 200 status code." do
          expect(response.status).to eq(200)
        end
        it "assigns @title." do
          expect(assigns(:title)).to eq("コンサート修正")
        end
        it "assigns @url." do
          expect(assigns(:url)).to eq(concerts_update_path)
        end
        it "assigns @concert." do
          expect(assigns(:concert)).to eq(concert)
        end
        it "reders the edit template." do
          expect(response).to render_template(:edit)
        end
      end
      context "when concert id is not exists" do
        before do
          get :edit, id: 100
        end
        it "redirect the index template." do
          expect(response).to redirect_to(concerts_index_path)
        end
        it "has a flash[:danger]." do
          expect(flash[:danger]).to eq("コンサート情報が存在しません。")
        end  
      end
    end

    context "when you are not signed in" do
      before do
        get :edit, id: concert.id
      end
      it "has a 302 status code." do
        expect(response.status).to eq(302)
      end
    end
  end

  describe "POST create" do
    def do_create_success
      post :create, 
        concert: {
          title: "テストコンサート", 
          open_at: Time.now,
          start_at: Time.now,
          place: "テストライブハウス",
          note: "[ゲスト]¥r¥n・アーティスト１¥r¥n・アーティスト２",
          active: true  
        }
    end
    def do_create_fail
      post :create, 
        concert: {
          title: nil, 
          open_at: Time.now,
          start_at: Time.now,
          place: "テストライブハウス",
          note: "[ゲスト]¥r¥n・アーティスト１¥r¥n・アーティスト２",
          active: true  
        }
    end

    context "when you are signed in" do
      before do
        sign_in admin
      end
      context "when there is no error" do
        it "should increment the concert count" do
          expect do
            do_create_success
          end.to change(Concert, :count).by(1)
        end
        it "redirect the index template." do
          do_create_success
          expect(response).to redirect_to(concerts_index_path)
        end
        it "has a flash[:success]." do
          do_create_success
          expect(flash[:success]).to eq("コンサート情報が登録されました。")
        end
      end
      context "when there are some errors" do
        it "should increment the concert count" do
          expect do
            do_create_fail
          end.to change(Concert, :count).by(0)
        end
        it "render the new template." do
          do_create_fail
          expect(response).to render_template(:new)
        end
      end
    end
    context "when you are not signed in" do
      before do
        do_create_success
      end
      it "has a 302 status code." do
        expect(response.status).to eq(302)
      end
    end
  end

  describe "POST edit" do
    def do_update_success
      post :update, 
        id: concert.id,
        concert: {
          title: "テストコンサート", 
          open_at: Time.now,
          start_at: Time.now,
          place: "テストライブハウス",
          note: "[ゲスト]¥r¥n・アーティスト１¥r¥n・アーティスト２",
          active: true  
        }
    end
    def do_update_fail
      post :update, 
        id: concert.id,
        concert: {
          title: nil, 
          open_at: Time.now,
          start_at: Time.now,
          place: "テストライブハウス",
          note: "[ゲスト]¥r¥n・アーティスト１¥r¥n・アーティスト２",
          active: true  
        }
    end
    context "when you are signed in" do
      before do
        sign_in admin
      end
      context "when concert id is exists" do
        context "when there is no error" do
          it "redirect the index template." do
            do_update_success
            expect(response).to redirect_to(concerts_index_path)
          end
          it "has a flash[:success]." do
            do_update_success
            expect(flash[:success]).to eq("コンサート情報が更新されました。")
          end
        end
        context "when there are some errors" do
          it "render the edit template." do
            do_update_fail
            expect(response).to render_template(:edit)
          end
        end  
      end
      context "when concert id is not exists" do
        before do
          post :update, id: 100
        end
        it "redirect the index template." do
          expect(response).to redirect_to(concerts_index_path)
        end
        it "has a flash[:danger]." do
          expect(flash[:danger]).to eq("コンサート情報が存在しません。")
        end
      end
    end
    context "when you are not signed in" do
      before do
        do_update_success
      end
      it "has a 302 status code." do
        expect(response.status).to eq(302)
      end
    end
  end

  describe "DELETE destroy" do
    context "when you are signed in" do
      before do
        sign_in admin
      end
      context "when concert id is exists" do
        before do
          delete :destroy, id: concert.id
        end
        it "redirect the index template." do
          expect(response).to redirect_to(concerts_index_path)
        end
        it "has a flash[:success]." do
          expect(flash[:success]).to eq("コンサート情報が削除されました。")
        end
      end
      context "when concert id is not exists" do
        before do
          delete :destroy, id: 100
        end
        it "redirect the index template." do
          expect(response).to redirect_to(concerts_index_path)
        end
        it "has a flash[:danger]." do
          expect(flash[:danger]).to eq("コンサート情報が存在しません。")
        end
      end
    end
    context "when you are not signed in" do
      before do
        delete :destroy, id: concert.id
      end
      it "has a 302 status code." do
        expect(response.status).to eq(302)
      end
    end
  end
end
