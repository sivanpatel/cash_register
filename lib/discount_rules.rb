require_relative 'products'

module DiscountRules

  BOGOF_PRODUCTS = %w(chocolate)
  HAPPY_HOUR_PRODUCTS = %w(beer soda)
  MEAL_DEAL_PRODUCTS = %w(sandwich soda chocolate)
  PRODUCTS = Products::PRODUCTS

  def happy_hour?
    current_time = Time.now
    (current_time.hour >= 17) && (current_time.hour < 19)
  end

  def apply_happy_hour_rule
    soda_quantity = find_quantity_of_product_in_cart("soda")
    beer_quantity = find_quantity_of_product_in_cart("beer")
    discounted_price = (beer_quantity * find_product_price("beer") + soda_quantity * find_product_price("soda")) / 2
    @total_price += discounted_price
    update_product_quantity("soda")
    update_product_quantity("beer")
  end

  def bogof_conditions_met
    products = []
    BOGOF_PRODUCTS.each do |prod|
      products << @products.find { |p| p[:product] == prod }
    end
    true unless products.empty? || !products.any?
  end

  def apply_bogof_discount
    BOGOF_PRODUCTS.each do |product|
      product_price = find_product_price(product)
      product_quantity = find_quantity_of_product_in_cart(product)
      @total_price += product_quantity % 2 == 0 ? (product_price * product_quantity)/2 : (product_price * (product_quantity / 2) + product_price)
      update_product_quantity(product)
    end
  end

  def meal_deal_conditions_met
    products = []
    MEAL_DEAL_PRODUCTS.each do |prod|
      products << @products.find { |p| p[:product] == prod }
    end
    products.compact.length == MEAL_DEAL_PRODUCTS.length
  end

  def apply_meal_deal_discount
    minimum_amount_of_products = [find_quantity_of_product_in_cart("soda"), find_quantity_of_product_in_cart("sandwich"), find_quantity_of_product_in_cart("chocolate")].min
    (MEAL_DEAL_PRODUCTS - ["chocolate"]).each do |product|
      @total_price += find_quantity_of_product_in_cart(product) * find_product_price(product)
      @products.find { |prod| prod[:product] == product }[:quantity] -= minimum_amount_of_products
    end
    @total_price += (find_quantity_of_product_in_cart("chocolate") - minimum_amount_of_products) * find_product_price("chocolate")
    @products.find { |prod| prod[:product] == "chocolate" }[:quantity] -= minimum_amount_of_products
  end

  def beer_condition_met
    find_quantity_of_product_in_cart("beer") >= 3
  end

  def apply_beer_discount
    number_of_beers_in_cart = find_quantity_of_product_in_cart("beer")
    beer_price = find_product_price("beer")
    @total_price += number_of_beers_in_cart % 3 == 0 ? (beer_price * number_of_beers_in_cart) * 0.9 :
        (beer_price * (number_of_beers_in_cart / 3) + (beer_price * (number_of_beers_in_cart % 3)))
    update_product_quantity("beer")
  end

  def tally_remaining_products
    @products.each do |prod|
      @total_price += find_product_price(prod[:product]) * find_quantity_of_product_in_cart(prod[:product])
    end
  end

  def update_product_quantity(product)
    if @products.find { |prod| prod[:product] == product }
      @products.find { |prod| prod[:product] == product }[:quantity] = 0
    end
  end

  def find_product_price(product)
    PRODUCTS.find { |prod| prod[:name] == product }[:price]
  end

  def find_quantity_of_product_in_cart(product)
    @products.find { |prod| prod[:product] == product }&.[](:quantity) || 0
  end

end
