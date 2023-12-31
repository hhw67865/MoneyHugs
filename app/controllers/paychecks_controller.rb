class PaychecksController < ApplicationController
  before_action :set_paycheck, only: %i[ show update destroy ]

  # GET /paychecks
  def index
    @paychecks = @current_user.paychecks

    render json: @paychecks.order(date: :desc)
  end

  # GET /paychecks/1
  def show
    render json: @paycheck
  end

  # POST /paychecks
  def create
    @paycheck = Paycheck.new(paycheck_params)

    if @paycheck.save
      render json: @paycheck, status: :created, location: @paycheck
    else
      render json: @paycheck.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /paychecks/1
  def update
    if @paycheck.update(paycheck_params)
      render json: @paycheck
    else
      render json: @paycheck.errors, status: :unprocessable_entity
    end
  end

  # DELETE /paychecks/1
  def destroy
    @paycheck.destroy!
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_paycheck
    @paycheck = @current_user.paychecks.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def paycheck_params
    params.require(:paycheck).permit(:date, :amount, :description, :income_source_id, income_source_attributes: [:name]).tap do |whitelisted|
      whitelisted[:income_source_attributes][:user] = @current_user if whitelisted[:income_source_attributes]
    end
  end
end
