# == Schema Information
#
# Table name: markets
#
#  id           :bigint           not null, primary key
#  country_code :string(255)
#  currency     :string(255)
#  name         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require "test_helper"

class MarketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
