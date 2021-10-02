json.array! @shops do |shop|
  json.id shop.id
  json.user_id shop.user_id
  json.market_id shop.market_id
  json.market shop.market
  json.account shop.account
  json.password shop.password
  json.order_count shop.orders.count
  json.receivable_document_count shop.receivable_documents.count
  json.created_at shop.created_at
  json.updated_at shop.updated_at
end
