class Api::V1::ProductsController < Api::V1::BaseController
    before_action :set_company, only: :index
    
    def index
      render json: @company.products.order(created_at: :desc)
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        render json: @product
      else
        render json: { error: @product.errors.full_messages.to_sentence }, status: 422
      end
    end

    def show
      stock = ShopStock.find_by(sku: params[:id])
      if (stock.present?)
        prod_obj = { sku: stock.sku, id: stock.product.id, name: stock.product.name, price: stock.price }
        render json: prod_obj
      else
        render json: "Product not found"
      end
    end

    def update
      @product = Product.find(params[:id])
      if @product.blank?
        respond_with_error "product with id #{params[:id]} not found.", :not_found
      elsif @product.update(product_params)
        render json: @product
      else
        render json: { error: @product.errors.full_messages.to_sentence }, status: 422
      end
    end

    def bulk_delete
        products = Product.where(id: params[:ids])
        if products.empty?
          render json: { error: "No products found with those IDs" }, status: 422
        else
          products_count = products.size
          products.destroy_all
          render json: "#{products_count} products has been deleted."
        end
    end
  
    def destroy
      if @product.blank?
        respond_with_error "Product with id #{params[:id]} not found.", :not_found
      elsif @product.destroy
        render json: @product
      else
        render json: { error: @product.errors.full_messages.to_sentence }, status: 422
      end
    end

    private
  
      def set_company
        @company = Company.find(params[:company_id])
      end

      def product_params
        params.require(:product).permit(:name, :company_id)
      end

end
  