class CreateReceivableDocumentService
  attr_reader :document

  def initialize(receivable_documents)
    @model = receivable_documents
  end

  def call(params)
    params.permit!

    @model.transaction do
      @document = @model.create
      @document.orders = @document.shop.orders.create(params[:orders])
      @document.issue!(
        maturity_date: 14.days.after.to_date.strftime('%F'),
        coupon_rate: 0.054 * 14
      )
    end
  end
end
