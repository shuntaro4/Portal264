class ReservationsController < ApplicationController
    def index
        @title        = "予約一覧"
        @reservations = Reservation.where("concert_id = ?", params[:concert_id])
    end

    def new
        @title        = "チケット予約フォーム"
        @url          = reservations_create_path(concert_id: params[:concert_id])
        @reservation  = Reservation.new(concert_id: params[:concert_id])
    end

    def edit
        if Reservation.exists?(id: params[:id])
            @title        = "予約修正"
            @url          = reservations_update_path(concert_id: params[:concert_id])
            @reservation  = Reservation.where("id = ?", params[:id]).first
        else
            redirect_to concert_index_path, flash: { danger: "予約情報がありません。" }
        end
    end

    def show
        redirect_to concert_index_path
    end

    def create
        @title        = "チケット予約フォーム"
        @url          = reservations_create_path(concert_id: params[:concert_id])
        @reservation  = Reservation.new(reservation_params)
        if @reservation.save
            redirect_to concerts_index_path, flash: { success: '予約情報が登録されました。' }
        else
            render :new
        end
    end

    def update
        if Reservation.exists?(id: params[:id])
            @title        = "予約修正"
            @url          = reservations_update_path(concert_id: params[:concert_id])
            @reservation  = Reservation.find(params[:id])
            if @reservation.update_attributes(reservation_params)
                redirect_to reservations_index_path(concert_id: params[:concert_id]), flash: { success: '予約情報が更新されました。' }
            else
                render :edit
            end
        else
            redirect_to concert_index_path, flash: { danger: "予約情報がありません。" }
        end
    end

    def destroy
        if Reservation.delete(params[:id])
            redirect_to reservations_index_path(concert_id: params[:concert_id]), flash: { success: '予約情報が削除されました。' }
        else
            render :destroy
        end
    end

    private

    def reservation_params
        params.require(:reservation).permit(
            :concert_id, :name, :mail, :ticket
        )
    end

end
