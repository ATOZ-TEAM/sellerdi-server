module Api
  class ShopsController < BaseController
    before_action :set_user
    before_action :set_collection
    before_action :set_shop, only: %i[ show edit update destroy ]

    # GET /shops or /shops.json
    # GET /api/users/:user_id/shops
    def index
      @shops = @shops.all
    end

    # GET /shops/1 or /shops/1.json
    # GET /api/users/:user_id/shops/:id
    def show
    end

    # POST /shops or /shops.json
    # POST /api/users/:user_id/shops
    def create
      @shop = @shops.new(shop_params)

      respond_to do |format|
        if @shop.save
          format.html { redirect_to @shop, notice: "Shop was successfully created." }
          format.json { render :show, status: :created, location: @shop }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @shop.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /shops/1 or /shops/1.json
    # PATCH/PUT /api/users/:user_id/shops/:id
    def update
      respond_to do |format|
        if @shop.update(shop_params)
          format.html { redirect_to @shop, notice: "Shop was successfully updated." }
          format.json { render :show, status: :ok, location: @shop }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @shop.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /shops/1 or /shops/1.json
    # DELETE /api/users/:user_id/shops/:id
    def destroy
      @shop.destroy
      respond_to do |format|
        format.html { redirect_to api_shops_url, notice: "Shop was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    def set_user
      @user = User.find(params[:user_id]) rescue nil
    end

    def set_collection
      @shops = (@user ? @user.shops : Shop).includes(:market, :receivable_documents)
    end

    def set_shop
      @shop = @shops.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shop_params
      params.fetch(:shop, {})
    end
  end
end
