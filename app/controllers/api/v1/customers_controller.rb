module Api
  module V1
    class CustomersController < ApplicationController
      before_action :set_customer, only: %i[ show update destroy ]

      # GET /customers
      def index
        @customers = Customer.all

        render json: @customers
      end

      # GET /customers/1
      def show
        render json: @customer
      end

      # POST /customers
      def create
        @customer = Customer.new(customer_params)

        if @customer.save
          render json: @customer, status: :created, location: [:api, :v1, @customer]
        else
          render json: @customer.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /customers/1
      def update
        if @customer.update(customer_params)
          render json: @customer
        else
          render json: @customer.errors, status: :unprocessable_entity
        end
      end

      # DELETE /customers/1
      def destroy
        @customer.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_customer
          @customer = Customer.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def customer_params
          params.require(:customer).permit(:legal_name, :phone_number, :address, :address_number,
                                            :complement, :neighbourhood, :city, :state, :postal_code,
                                            :register_date, :declared_revenues)
        end
    end
  end
end
