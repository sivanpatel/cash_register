require_relative 'discount_rules'

class Register
  include DiscountRules

  def total_price
    apply_discounts
    tally_remaining_products
    @total_price
  end

  def initialize(cart)
    @products = cart.products
    @total_price = 0
  end

  private

  def apply_discounts
    apply_meal_deal_discount if meal_deal_conditions_met
    apply_bogof_discount if bogof_conditions_met
    apply_beer_discount if beer_condition_met && !happy_hour?
    apply_happy_hour_rule if happy_hour?
  end

  def tally_remaining_products
    @products.each do |prod|
      @total_price += find_product_price(prod[:product]) * find_quantity_of_product_in_cart(prod[:product])
    end
  end

  def update_product_quantity(product, quantity)
    if @products.find { |prod| prod[:product] == product }
      @products.find { |prod| prod[:product] == product }[:quantity] -= quantity
    end
  end

  def find_product_price(product)
    PRODUCTS.find { |prod| prod[:name] == product }[:price]
  end

  def find_quantity_of_product_in_cart(product)
    @products.find { |prod| prod[:product] == product }&.[](:quantity) || 0
  end
end
