class Api::V1::VendorsController < Api::V1::BaseController
    before_action :set_company, only: :index

    def index
      render json: @company.vendors.order(created_at: :desc)
    end

    def create
        @vendor = Vendor.new(vendor_params)
        if @vendor.save
          render json: @vendor, serializer: VendorSerializer
        else
          render json: { error: @vendor.errors.full_messages.to_sentence }, status: 422
        end
    end

    def update
        @vendor = Vendor.find(params[:id])
        if @vendor.blank?
          respond_with_error "vendor with id #{params[:id]} not found.", :not_found
        elsif @vendor.update(vendor_params)
          render json: @vendor
        else
          render json: { error: @vendor.errors.full_messages.to_sentence }, status: 422
        end
    end
  
      def bulk_delete
          vendors = Vendor.where(id: params[:ids])
          if vendors.empty?
            render json: { error: "No vendors found with those IDs" }, status: 422
          else
            vendors_count = vendors.size
            vendors.destroy_all
            render json: "#{vendors_count} vendors has been deleted."
          end
      end
    
      def destroy
        if @vendor.blank?
          respond_with_error "vendor with id #{params[:id]} not found.", :not_found
        elsif @vendor.destroy
          render json: @vendor
        else
          render json: { error: @vendor.errors.full_messages.to_sentence }, status: 422
        end
      end
  
      private
    
        def set_company
          @company = Company.find(params[:company_id])
        end

        def vendor_params
          params.require(:vendor).permit(:name, :company_id)
        end

end