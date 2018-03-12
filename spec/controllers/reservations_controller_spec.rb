require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  let(:reservation) { FactoryBot.create(:reservation) }
  let(:admin) { FactoryBot.create(:admin) }
  let(:concert) { FactoryBot.create(:concert) }
  delegate :sign_in, to: 'controller.view_context'

  describe "GET index" do
    context "when you are signed in" do
      before do
        sign_in admin
        get :index, concert_id: reservation.concert_id
      end
      it "has a 200 status code." do
        expect(response.status).to eq(200)
      end
      it "assigns @title." do
        expect(assigns(:title)).to eq("予約一覧")
      end
      it "assigns @reservations." do
        expect(assigns(:reservations)).to eq([reservation])
      end
      it "reders the index template." do
        expect(response).to render_template("index")
      end  
    end
    context "when you are not signed in" do
      before do
        get :index, concert_id: reservation.concert_id
      end
      it "has a 302 status code." do
        expect(response.status).to eq(302)
      end
    end
  end

  describe "GET new" do
    before do
      get :new, concert_id: reservation.concert_id
    end
    it "has a 200 status code." do
      expect(response.status).to eq(200)
    end
    it "assigns @title." do
      expect(assigns(:title)).to eq("チケット予約フォーム")
    end
    it "assigns @url." do
      expect(assigns(:url)).to eq(reservations_create_path(concert_id: reservation.concert_id))
    end
    it "assigns @reservation." do
      expect(assigns(:reservation)).to be_a_new(Reservation)
    end
    it "reders the new template." do
      expect(response).to render_template("new")
    end  
  end

  describe "GET edit" do
    context "when you are signed in" do
      before do
        sign_in admin
      end
      context "when concert id is exists" do
        before do
          get :edit, concert_id: reservation.concert_id, id: reservation.id
        end
        it "has a 200 status code." do
          expect(response.status).to eq(200)
        end
        it "assigns @title." do
          expect(assigns(:title)).to eq("予約修正")
        end
        it "assigns @url." do
          expect(assigns(:url)).to eq(reservations_update_path(concert_id: reservation.concert_id))
        end
        it "assigns @concert." do
          expect(assigns(:reservation)).to eq(reservation)
        end
        it "reders the edit template." do
          expect(response).to render_template(:edit)
        end
      end
      context "when concert id is not exists" do
        before do
          get :edit, concert_id: reservation.concert_id, id: 100
        end
        it "redirect the index template." do
          expect(response).to redirect_to(reservations_index_path(concert_id: reservation.concert_id))
        end
        it "has a flash[:danger]." do
          expect(flash[:danger]).to eq("予約情報がありません。")
        end
      end
    end
    context "when you are not signed in" do
      before do
        get :edit, concert_id: reservation.concert_id, id: reservation.id
      end
      it "has a 302 status code." do
        expect(response.status).to eq(302)
      end
    end
  end

  describe "POST create" do
    def do_create_success
      post :create,
        concert_id: concert.id,
        reservation: {
          concert_id: concert.id,
          name: "テスト 太郎",
          mail: "portal264.test@gmail.com",
          ticket: 1
        }
    end
    def do_create_fail
      post :create,
        concert_id: concert.id,
        reservation: {
          concert_id: concert.id,
          name: nil,
          mail: nil,
          ticket: nil
        }
    end
    context "when there is no error" do
      it "assigns @title." do
        do_create_success
        expect(assigns(:title)).to eq("チケット予約フォーム")
      end
      it "assigns @url." do
        do_create_success
        expect(assigns(:url)).to eq(reservations_create_path(concert_id: concert.id))
      end
      it "should increment the concert count" do
        expect do
          do_create_success
        end.to change(Reservation, :count).by(1)
      end
      it "redirect the index template." do
        do_create_success
        expect(response).to redirect_to(concerts_index_path)
      end
      it "has a flash[:success]." do
        do_create_success
        expect(flash[:success]).to eq("予約情報が登録されました。")
      end
    end
    context "when there are some errors" do
      it "assigns @title." do
        do_create_fail
        expect(assigns(:title)).to eq("チケット予約フォーム")
      end
      it "assigns @url." do
        do_create_fail
        expect(assigns(:url)).to eq(reservations_create_path(concert_id: concert.id))
      end
      it "should not change the concert count" do
        expect do
          do_create_fail
        end.to change(Reservation, :count).by(0)
      end
      it "render the new template." do
        do_create_fail
        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST update" do
    def do_update_success
      post :update,
        concert_id: concert.id,
        id: reservation.id,
        reservation: {
          concert_id: concert.id,
          name: "テスト 太郎",
          mail: "portal264.test@gmail.com",
          ticket: 1
        }
    end
    def do_update_fail
      post :update,
        concert_id: concert.id,
        id: reservation.id,
        reservation: {
          concert_id: concert.id,
          name: nil,
          mail: nil,
          ticket: nil
        }
    end

    context "when you are signed in" do
      before do
        sign_in admin
      end
      context "when reservation id is exists" do
        it "assigns @title." do
          do_update_success
          expect(assigns(:title)).to eq("予約修正")
        end
        it "assigns @url." do
          do_update_success
          expect(assigns(:url)).to eq(reservations_update_path(concert_id: concert.id))
        end
        context "when there is no error" do
          it "redirect the index template." do
            do_update_success
            expect(response).to redirect_to(reservations_index_path(concert_id: concert.id))
          end
          it "has a flash[:success]." do
            do_update_success
            expect(flash[:success]).to eq("予約情報が更新されました。")
          end
        end
        context "when there are some errors" do
          it "render the edit template." do
            do_update_fail
            expect(response).to render_template(:edit)
          end
        end  
      end
      context "when reservation id is not exists" do
        before do
          post :update,
            concert_id: concert.id,
            id: 100
        end
        it "redirect the concerts index template." do
          expect(response).to redirect_to(concerts_index_path)
        end
        it "has a flash[:danger]." do
          expect(flash[:danger]).to eq("予約情報がありません。")
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
      context "when reservation id is exists" do
        before do
          delete :destroy, concert_id: concert.id, id: reservation.id
        end
        it "redirect the index template." do
          expect(response).to redirect_to(reservations_index_path(concert_id: concert.id))
        end
        it "has a flash[:success]." do
          expect(flash[:success]).to eq("予約情報が削除されました。")
        end
      end
      context "when reservation id is not exists" do
        before do
          delete :destroy, concert_id: concert.id, id: 100
        end
        it "redirect the index template." do
          expect(response).to redirect_to(reservations_index_path(concert_id: concert.id))
        end
        it "has a flash[:danger]." do
          expect(flash[:danger]).to eq("予約情報が存在しません。")
        end
      end
    end
    context "when you are not signed in" do
      before do
        delete :destroy, concert_id: concert.id, id: reservation.id
      end
      it "has a 302 status code." do
        expect(response.status).to eq(302)
      end
    end
  end
end
