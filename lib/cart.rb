require_relative 'products'

class Cart

  def initialize
    @products = []
  end

  def products
    @products
  end

  def add_product(product)
    if product_recognized?(product)
      @products << product
    else
      raise "Unrecognized product: #{product}"
    end
  end

  def remove_product(product)
    @products.delete(product) {"product not in cart"}
  end

  private

  def product_recognized?(product)
    Products::PRODUCTS.find { |prod| prod[:name] == product }
  end
end
