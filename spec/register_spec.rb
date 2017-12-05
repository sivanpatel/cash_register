require './lib/register'

describe Register do

  let(:register) { Register.new(cart) }
  let(:cart) { double("cart") }

  it 'returns the price with 1 product in the cart' do
    allow(cart).to receive(:products) { [{ product: "beer", quantity: 1 }] }
    expect(register.total_price).to eq 1.5
  end

  it 'charges for only 1 chocolate when 2 are added' do
    allow(cart).to receive(:products) { [{ product: "chocolate", quantity: 2 }] }
    expect(register.total_price).to eq 3.10
  end

  it 'discounts 10% for every batch of 3 beers bought' do
    allow(cart).to receive(:products) { [{ product: "beer", quantity: 3 }] }
    expect(register.total_price).to eq 4.05
  end

  it 'gives a free chocolate if soda and sandwich are in the cart' do
    allow(cart).to receive(:products) { [{ product: "soda", quantity: 1 },
                                         { product: "sandwich", quantity: 1 },
                                         { product: "chocolate", quantity: 1  }] }
    expect(register.total_price).to eq 6.50
  end

  it 'gives 50% off beer and soda when in happy hour' do
    allow(cart).to receive(:products) { [{ product: "beer", quantity: 1 },
                                         { product: "soda", quantity: 1 }] }
    allow(Time).to receive(:now) { Time.new(2017, 12, 03, 17, 15, 00) }
    expect(register.total_price).to eq 2.00
  end

  it 'only applies happy hour discount if buying more than 3 beers during happy hour' do
    allow(cart).to receive(:products) { [{ product: "beer", quantity: 5 }] }
    allow(Time).to receive(:now) { Time.new(2017, 12, 03, 17, 15, 00) }
    expect(register.total_price).to eq 3.75
  end

  it 'correctly calculates the first given test' do
    allow(cart).to receive(:products) { [{ product: "beer", quantity: 4 },
                                         { product: "chips", quantity: 2 }] }
    expect(register.total_price).to eq 9.55
  end

  it 'correctly calculates the second given test' do
    allow(cart).to receive(:products) { [{ product: "beer", quantity: 1 },
                                         { product: "chocolate", quantity: 4 }] }
    allow(Time).to receive(:now) { Time.new(2017, 12, 03, 17, 15, 00) }
    expect(register.total_price).to eq 6.95
  end
end
