class Api::V1::TransactionsController < Api::V1::BaseController

  def create
    ActiveRecord::Base.transaction do
      transaction = Transaction.create(name: 'test')
      params[:transaction][:products].each do |key, value|
        stock = ShopStock.find_by(product_id: key)
          if stock.quantity >= value
            stock.decrement!(:quantity, by=value)
            transaction.transaction_records.create(product_id: key, quantity: value)
          else
            # payload = {
            #   error: "No such user; check the submitted email address",
            #   status: 400
            # }
            # render :json => payload, :status => :bad_request
            render json: { message: "Stock is not enough", status: 400}
            raise ActiveRecord::Rollback
          end
      end
      render json: { message: "Transaction completed successfully", status: 200 }
    end
  end

end
