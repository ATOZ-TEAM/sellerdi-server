# == Schema Information
#
# Table name: shops
#
#  id         :bigint           not null, primary key
#  account    :string(255)
#  password   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  market_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_shops_on_market_id  (market_id)
#  index_shops_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (market_id => markets.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ShopTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
