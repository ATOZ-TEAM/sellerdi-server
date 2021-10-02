# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

seed_src = Rails.application.credentials.dig(:seed)

# [환율 데이터]
#
# 첫 번째 [환율 데이터 조회 요청]을 생성합니다.
# 170여개 국가의 실시간 환율 정보를 함께 불러와 저장합니다.
ExchangeService::UpdateService.call

# [마켓 데이터]
#
# 쇼피 - 말/싱/대/배/태/필
Market.create([
  { name: 'shopee', country_code: 'my', currency: 'MYR' },
  { name: 'shopee', country_code: 'sg', currency: 'SGD' },
  { name: 'shopee', country_code: 'tw', currency: 'TWD' },
  { name: 'shopee', country_code: 'vn', currency: 'VND' },
  { name: 'shopee', country_code: 'th', currency: 'THB' },
  { name: 'shopee', country_code: 'ph', currency: 'PHP' },
])

# [회원 데이터]
#
# 은솔이는
user_env = seed_src.dig(:users, 0)
eunsol = User.create(
  name: user_env.dig(:name),
  email: user_env.dig(:email),
  password: user_env.dig(:password)
)

# [계좌 정보]
#
# 셀라비 서비스에 계좌를 등록합니다.
bank_account_env = seed_src.dig(:bank_accounts, 0)
eunsol.bank_accounts.create(
  account_num: bank_account_env.dig(:account_num),
  bank_name: bank_account_env.dig(:bank_name),
  holder_name: bank_account_env.dig(:holder_name)
)

# [샵 데이터]
#
# 쇼피 말/싱 두개의 샵을 운영합니다.

## 말레이시아 쇼피 샵 세팅
shopee_my = Market.find_by(name: 'shopee', country_code: 'my')
shopee_my_shop = eunsol.shops.create do |shop|
  shop_account_env = seed_src.dig(:shops, 0)
  shop.market = shopee_my
  shop.account = shop_account_env.dig(:account)
  shop.password = shop_account_env.dig(:password)
end

## 싱가폴 쇼피 샵 세팅
shopee_sg = Market.find_by(name: 'shopee', country_code: 'sg')
shopee_sg_shop = eunsol.shops.create do |shop|
  shop_account_env = seed_src.dig(:shops, 1)
  shop.market = shopee_sg
  shop.account = shop_account_env.dig(:account)
  shop.password = shop_account_env.dig(:password)
end

# 말레이 1차 정산
shopee_my_shop.receivable_documents.create(released_at: '2021-09-08 02:12 KST').tap do |receivable_document|
  receivable_document.orders = shopee_my_shop.orders.create([
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-26", order_id: "210826KA1RYFC7", transaction_data: { amount: 72.39, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-29", order_id: "210829UG566MQ5", transaction_data: { amount: 79.91, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-29", order_id: "210829UG566MQ5", transaction_data: { amount: 79.91, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-20", order_id: "2108203Y0CGMHS", transaction_data: { amount: 80.01, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-25", order_id: "210825H342B6BU", transaction_data: { amount: 498.19, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-15", order_id: "210815MQPR6JRN", transaction_data: { amount: 108.03, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-16", order_id: "210816NVMANE0F", transaction_data: { amount: 69.33, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-14", order_id: "210814JU36TEP8", transaction_data: { amount: 116.37, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-23", order_id: "210823B86H50M5", transaction_data: { amount: 160.52, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-22", order_id: "210822919QWFG5", transaction_data: { amount: 79.61, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-20", order_id: "2108203K79C2AG", transaction_data: { amount: 145.03, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-13", order_id: "210813FBF4KAGS", transaction_data: { amount: 211.5, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-14", order_id: "210814JJNM2PCD", transaction_data: { amount: 220.56, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-13", order_id: "210813GAJ2TQBQ", transaction_data: { amount: 97.37, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", date: "2021-08-16", order_id: "210816NQSVH55T", transaction_data: { amount: 76.28, symbol: "RM" }, status_message: 'Buyer confirmed order received' },
  ])
  receivable_document.issue!(maturity_date: '2021-09-23', coupon_rate: 0.0)
end

# 말레이 2차 정산
shopee_my_shop.receivable_documents.create(released_at: '2021-09-14 14:19 KST').tap do |receivable_document|
  receivable_document.orders = shopee_my_shop.orders.create([
    { first_item_img: 'https://cf.shopee.com.my/file/06dedd0e5f1f5d42e69cd4b9202b20fc_tn', order_id: '210908QGW36JQK', date: '2021-09-08', transaction_data: { symbol: 'RM', amount: 79.61 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn', order_id: '21090394V4NRUF', date: '2021-09-03', transaction_data: { symbol: 'RM', amount: 159.62 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.com.my/file/a3c393b4c326e3a4740915ac4031b7f3_tn', order_id: '21090152DE1K7D', date: '2021-09-01', transaction_data: { symbol: 'RM', amount: 79.76 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.com.my/file/ac7a1f8c97cf9ef98f547f8184a70878_tn', order_id: '2108311HMA6NYM', date: '2021-08-31', transaction_data: { symbol: 'RM', amount: 79.91 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.com.my/file/ac7a1f8c97cf9ef98f547f8184a70878_tn', order_id: '21081929DVPA4T', date: '2021-08-19', transaction_data: { symbol: 'RM', amount: 160.05 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.com.my/file/3c89ce3cd8adacb86365a97ab5fd57f2_tn', order_id: '210826KA1RYFC7', date: '2021-08-26', transaction_data: { symbol: 'RM', amount: 72.39 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.com.my/file/ac7a1f8c97cf9ef98f547f8184a70878_tn', order_id: '210829UG566MQ5', date: '2021-08-29', transaction_data: { symbol: 'RM', amount: 79.91 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn', order_id: '210825H36BYYNQ', date: '2021-08-25', transaction_data: { symbol: 'RM', amount: 238.43 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.com.my/file/a3c393b4c326e3a4740915ac4031b7f3_tn', order_id: '2108203Y0CGMHS', date: '2021-08-20', transaction_data: { symbol: 'RM', amount: 80.01 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.com.my/file/ad98974f8c35a71e3e973689ed94fdc7_tn', order_id: '210825H342B6BU', date: '2021-08-25', transaction_data: { symbol: 'RM', amount: 498.19 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn', order_id: '210815MQPR6JRN', date: '2021-08-15', transaction_data: { symbol: 'RM', amount: 108.03 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.com.my/file/3c89ce3cd8adacb86365a97ab5fd57f2_tn', order_id: '210816NVMANE0F', date: '2021-08-16', transaction_data: { symbol: 'RM', amount: 69.33 }, status_message: 'Buyer confirmed order received' },
  ])
  receivable_document.issue!(maturity_date: '2021-09-23', coupon_rate: 0.0)
end

# 싱가폴 1차 정산
shopee_sg_shop.receivable_documents.create(released_at: '2021-09-14 14:37 KST').tap do |receivable_document|
  receivable_document.orders = shopee_sg_shop.orders.create([
    { first_item_img: 'https://cf.shopee.sg/file/e606d6c8f2c10e8ddade9e9d21504b3c_tn', order_id: '210909SXENGM3V', date: '2021-09-09', transaction_data: { symbol: '$', amount: 21.57 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.sg/file/7238f52aff3830eba7e0ae6bdb083835_tn', order_id: '21090155SCKQ1R', date: '2021-09-01', transaction_data: { symbol: '$', amount: 23.55 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.sg/file/e606d6c8f2c10e8ddade9e9d21504b3c_tn', order_id: '210824EKN3EATN', date: '2021-08-24', transaction_data: { symbol: '$', amount: 21.57 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.sg/file/e606d6c8f2c10e8ddade9e9d21504b3c_tn', order_id: '210826KKFSVPA6', date: '2021-08-26', transaction_data: { symbol: '$', amount: 21.61 }, status_message: 'Buyer confirmed order received' },
    { first_item_img: 'https://cf.shopee.sg/file/e606d6c8f2c10e8ddade9e9d21504b3c_tn', order_id: '210828RJRYH6JA', date: '2021-08-28', transaction_data: { symbol: '$', amount: 45.63 }, status_message: 'Buyer confirmed order received' },
  ])
  receivable_document.issue!(maturity_date: '2012-09-23', coupon_rate: 0.0)
end

# 말레이 3차 정산
shopee_my_shop.receivable_documents.create(released_at: '2021-09-25 02:32 KST').tap do |receivable_document|
  receivable_document.orders = shopee_my_shop.orders.create([
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", order_id: "2109149BFS2PSA", date: '2021-09-14', transaction_data: { symbol: "RM", amount: 79.74 }, status_message: "Buyer confirmed order received" },
    { first_item_img: "https://cf.shopee.com.my/file/ad98974f8c35a71e3e973689ed94fdc7_tn", order_id: "210916DUN2X51M", date: '2021-09-16', transaction_data: { symbol: "RM", amount: 79.91 }, status_message: "Buyer confirmed order received" },
    { first_item_img: "https://cf.shopee.com.my/file/a3c393b4c326e3a4740915ac4031b7f3_tn", order_id: "210917ETNFYSHE", date: '2021-09-17', transaction_data: { symbol: "RM", amount: 389.39 }, status_message: "Buyer confirmed order received" },
    { first_item_img: "https://cf.shopee.com.my/file/ad98974f8c35a71e3e973689ed94fdc7_tn", order_id: "2109111S46EGFU", date: '2021-09-11', transaction_data: { symbol: "RM", amount: 79.91 }, status_message: "Buyer confirmed order received" },
    { first_item_img: "https://cf.shopee.com.my/file/ac7a1f8c97cf9ef98f547f8184a70878_tn", order_id: "210903A1TC5SB0", date: '2021-09-03', transaction_data: { symbol: "RM", amount: 79.74 }, status_message: "Buyer confirmed order received" },
    { first_item_img: "https://cf.shopee.com.my/file/ac7a1f8c97cf9ef98f547f8184a70878_tn", order_id: "210904D4A252A8", date: '2021-09-04', transaction_data: { symbol: "RM", amount: 160.22 }, status_message: "Buyer confirmed order received" },
    { first_item_img: "https://cf.shopee.com.my/file/ad98974f8c35a71e3e973689ed94fdc7_tn", order_id: "210906J8GUTHD1", date: '2021-09-06', transaction_data: { symbol: "RM", amount: 159.92 }, status_message: "Buyer confirmed order received" },
    { first_item_img: "https://cf.shopee.com.my/file/ac7a1f8c97cf9ef98f547f8184a70878_tn", order_id: "210906J65GS9YX", date: '2021-09-06', transaction_data: { symbol: "RM", amount: 79.91 }, status_message: "Buyer confirmed order received" },
    { first_item_img: "https://cf.shopee.com.my/file/ad98974f8c35a71e3e973689ed94fdc7_tn", order_id: "210909RT9Q6E58", date: '2021-09-09', transaction_data: { symbol: "RM", amount: 79.91 }, status_message: "Buyer confirmed order received" },
    { first_item_img: "https://cf.shopee.com.my/file/3c89ce3cd8adacb86365a97ab5fd57f2_tn", order_id: "210908P6YBHXAS", date: '2021-09-08', transaction_data: { symbol: "RM", amount: 2320.12 }, status_message: "Buyer confirmed order received" },
    { first_item_img: "https://cf.shopee.com.my/file/9f3a3b447027ff4b6da3bcbd7be9e719_tn", order_id: "210909RXF7CCFE", date: '2021-09-09', transaction_data: { symbol: "RM", amount: 79.74 }, status_message: "Buyer confirmed order received" },
    { first_item_img: "https://cf.shopee.com.my/file/ac7a1f8c97cf9ef98f547f8184a70878_tn", order_id: "210909S0J6P72B", date: '2021-09-09', transaction_data: { symbol: "RM", amount: 79.91 }, status_message: "Buyer confirmed order received" }
  ])
  receivable_document.issue!(maturity_date: '2021-10-14', coupon_rate: 0.0)
end
