class ConcertsController < ApplicationController

    def index
        @title    = 'コンサート一覧'
        @concerts = Concert.all
    end

    def new
        @title   = 'コンサート新規登録'
        @concert = Concert.new
    end

    def show
        @title   = 'コンサート詳細'
        @concert = Concert.find(params[:id])
    end

    def create
        @concert = Concert.new(concert_params)
        if @concert.save
           redirect_to concerts_index_path, flash: { success: 'コンサート情報が登録されました。' }
        else
            render :new
        end
    end

    def update
    end

    def destroy
        if Concert.delete(params[:id])
            redirect_to :concert_index, flash: { success: 'コンサート情報が削除されました。' }
        else
            render :index
        end
    end

    private

    def concert_params
        params.require(:concert).permit(
            :title, :open_at, :start_at, :end_at, :place, :free, :note
        )
    end

end
