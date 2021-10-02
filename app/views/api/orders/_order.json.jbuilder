json.extract! order, *[
  :id,
  :shop_id,
  :first_item_img,
  :date,
  :order_id,
  :transaction_data,
  :status_message,
]

json_builder_timestamp(json, order, include_url: api_user_shop_order_url(@user, @shop, order, format: :json))
