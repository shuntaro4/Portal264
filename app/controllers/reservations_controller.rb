class ReservationsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :index]
  before_action :set_reservation, only: [:edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @concert = Concert.find(params[:concert_id])
    @reservations = Reservation.all
  end

  # GET /reservations/new
  def new
    @concert = Concert.find(params[:concert_id])
    @reservation = @concert.reservations.build
    if @reservation.concert.nil? or !@reservation.concert.active
      redirect_to concerts_index_path
    end
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @concert = Concert.find(params[:concert_id])
    @reservation = @concert.reservations.build(reservation_params)

    respond_to do |format|
      if @reservation.save
        NotificationMailer.send_confirm_to_user(@reservation).deliver_later
        format.html { redirect_to concerts_url, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to concert_reservations_url, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to concert_reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @concert = Concert.find(params[:concert_id])
      @reservation = @concert.reservations.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:concert_id, :name, :mail, :ticket)
    end
end
