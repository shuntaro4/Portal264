class ConcertsController < ApplicationController

    def index
        @title    = 'Concert'
        @concerts = Concert.all
    end

    def new
        @title   = 'Concert New'
        @concert = Concert.new
    end

    def show
    end

    def create
        @concert = Concert.new(concert_params)
        if @concert.save
            redirect_to concerts_index_path, flash: { success: 'コンサート情報が登録されました。' }
        else
            render :new, flash: { error: 'コンサート情報の登録に失敗しました。' }
        end
    end

    private

    def concert_params
        params.require(:concert).permit(
            :title, :open_at, :start_at, :end_at, :place, :free, :note
        )
    end

end
