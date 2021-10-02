module Api
  class OrdersController < BaseController
    before_action :set_user
    before_action :set_shop
    before_action :set_collection
    before_action :set_order, only: %i[ show edit update destroy ]

    # GET /orders or /orders.json
    # GET /api/users/:user_id/shops/:shop_id/orders
    def index
      @orders = @orders.all
    end

    # GET /orders/1 or /orders/1.json
    # GET /api/users/:user_id/shops/:shop_id/orders/:id(.:format)
    def show
    end

    # POST /orders or /orders.json
    # POST /api/users/:user_id/shops/:shop_id/orders
    def create
      @order = @orders.new(order_params)

      respond_to do |format|
        if @order.save
          format.html { redirect_to @order, notice: "Order was successfully created." }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /orders/1 or /orders/1.json
    # PATCH/PUT /api/users/:user_id/shops/:shop_id/orders/:id
    def update
      respond_to do |format|
        if @order.update(order_params)
          format.html { redirect_to @order, notice: "Order was successfully updated." }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /orders/1 or /orders/1.json
    # DELETE /api/users/:user_id/shops/:shop_id/orders/:id
    def destroy
      @order.destroy
      respond_to do |format|
        format.html { redirect_to api_orders_url, notice: "Order was successfully destroyed." }
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
      @orders = @shop ? @shop.orders : Order
    end

    def set_order
      @order = @orders.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.fetch(:order, {})
    end
  end
end
