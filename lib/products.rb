require 'yaml'

class Products

  def self.load_products
    YAML.load_file('./lib/products.yml').map do |product|
      product.each_with_object({}) do |(key, value), result|
        result[key.to_sym] = value
      end
    end
  end

  PRODUCTS = Products.load_products.freeze
end
