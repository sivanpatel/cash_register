require_relative 'products'

class Cart

  def initialize
    @products = []
  end

  def products
    @products
  end

  def add_product_to_cart(product)
    if product_recognized?(product)
      add_product(product)
    else
      raise "Unrecognized product: #{product}"
    end
  end

  def remove_product_from_cart(product)
    @products.delete_if { |prod| prod[:product] == product }
  end

  private

  def product_recognized?(product)
    Products::PRODUCTS.find { |prod| prod[:name] == product }
  end

  def add_product(product)
    if @products.find { |prod| prod[:product] == product }
      @products.find { |prod| prod[:product] == product }[:quantity] += 1
    else
      @products << { product: product, quantity: 1 }
    end
  end
end
