class Api::V1::ProductsController < Api::V1::BaseController
  
    def index
      render json: Product.all.order(created_at: :desc)
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        render json: { product: @product, notice: "Product created successfully" }
      else
        render json: { error: @product.errors.full_messages.to_sentence }, status: 422
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
          render json: { notice: "#{products_count} products has been deleted." }
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
  
      def product_params
        params.require(:product).permit(:name)
      end

end
  