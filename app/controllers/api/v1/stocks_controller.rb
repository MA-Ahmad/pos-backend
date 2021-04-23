class Api::V1::StocksController < Api::V1::BaseController
    before_action :set_stock, only: [:edit, :update, :destroy]
  
    def index
      render json: Stock.includes(:product, :vendor).all.order(created_at: :desc)
    end
  
    def create
      @stock = Stock.new(stock_params)
      if @stock.save
        render json: { stock: @stock, notice: "Stock created successfully" }
      else
        render json: { error: @stock.errors.full_messages.to_sentence }, status: 422
      end
    end
  
    def update
      if @stock.blank?
        respond_with_error "Stock with id #{params[:id]} not found.", :not_found
      elsif @stock.update(stock_params)
        render json: @stock
      else
        render json: { error: @stock.errors.full_messages.to_sentence }, status: 422
      end
    end

    def bulk_delete
        stocks = Stock.where(id: params[:ids])
        if stocks.empty?
          render json: { error: "No stocks found with those IDs" }, status: 422
        else
          stocks_count = stocks.size
          stocks.destroy_all
          render json: { notice: "#{stocks_count} stocks has been added deleted." }
        end
    end
  
    def destroy
      if @stock.blank?
        respond_with_error "Stock with id #{params[:id]} not found.", :not_found
      elsif @stock.destroy
        render json: @stock
      else
        render json: { error: @stock.errors.full_messages.to_sentence }, status: 422
      end
    end
  
    private
  
      def set_stock
        @stock = Stock.find(params[:id])
      end
  
      def stock_params
        params.require(:stock).permit(:quantity, :price, :vendor_id, :product_id)
      end
  end
  