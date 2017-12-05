require_relative 'discount_rules'
require 'pry'

class Register
  include DiscountRules

  def total_price
    apply_meal_deal_discount if meal_deal_conditions_met
    apply_bogof_discount if bogof_conditions_met
    apply_happy_hour_rule if happy_hour?
    apply_beer_discount if beer_condition_met
    tally_remaining_products
    @total_price
  end

  def initialize(cart)
    @products = cart.products
    @total_price = 0
  end
end
