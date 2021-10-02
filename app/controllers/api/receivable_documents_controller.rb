module Api
  class ReceivableDocumentsController < BaseController
    before_action :set_user
    before_action :set_shop
    before_action :set_collection
    before_action :set_receivable_document, only: %i[ show edit update destroy ]

    # GET /api/users/:user_id/shops/:shop_id/receivable_documents
    def index
      @receivable_documents = @receivable_documents.all
    end

    # GET /api/users/:user_id/shops/:shop_id/receivable_documents/:id(.:format)
    def show
    end

    # POST /api/users/:user_id/shops/:shop_id/receivable_documents
    def create
      @receivable_document = @receivable_documents.new(receivable_document_params)

      respond_to do |format|
        if @receivable_document.save
          format.html { redirect_to @receivable_document, notice: "Receivable document was successfully created." }
          format.json { render :show, status: :created, location: @receivable_document }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @receivable_document.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /api/users/:user_id/shops/:shop_id/receivable_documents/:id
    def update
      respond_to do |format|
        if @receivable_document.update(receivable_document_params)
          format.html { redirect_to @receivable_document, notice: "Receivable document was successfully updated." }
          format.json { render :show, status: :ok, location: @receivable_document }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @receivable_document.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /api/users/:user_id/shops/:shop_id/receivable_documents/:id
    def destroy
      @receivable_document.destroy
      respond_to do |format|
        format.html { redirect_to api_receivable_documents_url, notice: "Receivable document was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    def set_user
      @user = User.find(params[:user_id]) rescue nil
    end

    def set_shop
      @shop = @user.shops.find(params[:shop_id]) rescue nil
    end

    def set_collection
      @receivable_documents = (@shop ? @shop.receivable_documents : ReceivableDocument).includes(:captured_transaction, :bond, order_of_receivable_documents: :order)
    end

    def set_receivable_document
      @receivable_document = @receivable_documents.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def receivable_document_params
      params.fetch(:receivable_document, {})
    end
  end
end
