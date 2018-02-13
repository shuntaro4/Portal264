class ConcertsController < ApplicationController
    before_action :signed_in_admin, only: [:new, :edit, :create, :update, :destroy]

    def index
        @title    = 'コンサート一覧'
        @concerts = Concert.all.order(open_at: :desc)
    end

    def new
        @title    = 'コンサート新規登録'
        @url      = concerts_create_path
        @concert  = Concert.new
    end

    def edit
        if Concert.exists?(id: params[:id])
            @title    = 'コンサート修正'
            @url      = concerts_update_path
            @concert  = Concert.find(params[:id])
        else
            redirect_to concerts_index_path, flash: { danger: "コンサート情報が存在しません。" }
        end
    end

    def show
        if Concert.exists?(id: params[:id])
            @title    = 'コンサート詳細'
            @concert  = Concert.find(params[:id])
        else
            redirect_to concerts_index_path, flash: { danger: "コンサート情報が存在しません。" }
        end
    end

    def create
        @concert  = Concert.new(concert_params)
        if @concert.save
            redirect_to concerts_index_path, flash: { success: 'コンサート情報が登録されました。' }
        else
            render :new
        end
    end

    def update
        if Concert.exists?(id: params[:id])
            @concert = Concert.find(params[:id])
            if @concert.update_attributes(concert_params)
                redirect_to concerts_index_path, flash: { success: 'コンサート情報が更新されました。' }
            else
                render :edit
            end
        else
            redirect_to concerts_index_path, flash: { danger: "コンサート情報が存在しません。" }
        end
    end

    def destroy
        if Concert.delete(params[:id])
            redirect_to concerts_index_path, flash: { success: 'コンサート情報が削除されました。' }
        else
            redirect_to concerts_index_path, flash: { danger: "コンサート情報が存在しません。" }
        end
    end

    private

    def concert_params
        params.require(:concert).permit(
            :title, :open_at, :start_at, :end_at, :place, :free, :note, :active
        )
    end
end
