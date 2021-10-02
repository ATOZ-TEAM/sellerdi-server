json.extract! shop, *[
  :id,
  :user_id,
  :market_id,
  :market,
  :account,
  :password,
]
json.order_count shop.orders.count
json.receivable_document_count shop.receivable_documents.count
json_builder_timestamp(json, shop, include_url: api_user_shop_url(@user, shop, format: :json))
