class ReservationsController < ApplicationController
    def index
        @title = "予約一覧"
        @reservations = Reservation.where("concert_id = ?", params[:concert_id])
    end

    def show
    end

    def new
    end

    def edit
    end
end
