require './lib/cart.rb'

describe Cart do

  it 'starts with an empty cart' do
    cart = Cart.new
    expect(cart.products).to be_empty
  end

  it 'can add products to the cart' do
    cart = Cart.new
    cart.add_product("beer")
    expect(cart.products).to eq ["beer"]
  end

  it 'will not add an unrecognized product to the cart' do
    cart = Cart.new
    expect { cart.add_product("sausages") }
      .to raise_error 'Unrecognized product: sausages'
    expect(cart.products).to be_empty
  end

  it 'can remove products from the cart' do
    cart = Cart.new
    cart.add_product("beer")
    expect(cart.products).to eq ["beer"]
    cart.remove_product("beer")
    expect(cart.products).to be_empty
  end

  it 'will raise an error if trying to delete an item not in cart' do
    cart = Cart.new
    expect(cart.remove_product("beer")).to eq "product not in cart"
  end
end
