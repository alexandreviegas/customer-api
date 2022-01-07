module Api
  module V1
    class BankAccountsController < ApplicationController
      before_action :set_customer
      before_action :set_bank_account, only: %i[ show update destroy ]

      # GET /customers/1/bank_accounts
      def index
        @bank_accounts = @customer.bank_accounts.all

        render json: @bank_accounts
      end

      # GET /customers/1/bank_accounts/1
      def show
        render json: @bank_account
      end

      # POST /customers/1/bank_accounts
      def create
        @bank_account = @customer.bank_accounts.new(bank_account_params)

        if @bank_account.save
          render json: @bank_account, status: :created, location: [:api, :v1, @customer, @bank_account]
        else
          render json: @bank_account.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /customers/1/bank_accounts/1
      def update
        if @bank_account.update(bank_account_params)
          render json: @bank_account
        else
          render json: @bank_account.errors, status: :unprocessable_entity
        end
      end

      # DELETE /customers/1/bank_accounts/1
      def destroy
        @bank_account.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_customer
          @customer = Customer.find(params[:customer_id])
        end

        def set_bank_account
          @bank_account = @customer.bank_accounts.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def bank_account_params
          params.require(:bank_account).permit(:customer_id, :bank_code, :agency_code, :account_number)
        end
    end
  end
end
