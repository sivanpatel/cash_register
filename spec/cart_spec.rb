require './lib/cart.rb'

describe Cart do
  let(:cart) { Cart.new }

  it 'starts with an empty cart' do
    expect(cart.products).to be_empty
  end

  it 'can add products to the cart' do
    cart.add_product_to_cart("beer")
    expect(cart.products).to eq [{ product: "beer", quantity: 1}]
  end

  it 'can add multiple of the same product to the cart' do
    cart.add_product_to_cart("beer")
    cart.add_product_to_cart("beer")
    expect(cart.products).to eq [{ product: "beer", quantity: 2 }]
  end
  it 'will not add an unrecognized product to the cart' do
    expect { cart.add_product_to_cart("sausages") }
      .to raise_error 'Unrecognized product: sausages'
    expect(cart.products).to be_empty
  end

  it 'can remove products from the cart' do
    cart.add_product_to_cart("beer")
    cart.remove_product_from_cart("beer")
    expect(cart.products).to be_empty
  end
end
