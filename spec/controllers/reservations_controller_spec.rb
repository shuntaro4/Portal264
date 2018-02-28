require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  let(:reservation) { FactoryBot.create(:reservation) }
  let(:admin) { FactoryBot.create(:admin) }
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
end
