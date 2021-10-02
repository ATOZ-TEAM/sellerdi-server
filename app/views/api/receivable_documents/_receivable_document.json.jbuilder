json.extract! receivable_document, *[
  :id,
  :shop_id,
  :released_at,
  :bond,
  :captured_transaction,
  :received_bank_account,
  :order_count,
  :order_amount_sum,
  :orders,
]

json_builder_timestamp(json, receivable_document, include_url: api_user_shop_receivable_document_url(@user.id, @shop.id, receivable_document, format: :json))
