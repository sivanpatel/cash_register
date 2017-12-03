require './lib/products.rb'

describe Products do

  it 'loads a list of products' do
    expect(Products.load_products).to eq([{:name=>"beer", :price=>1.5}, {:name=>"chips", :price=>2.0}, {:name=>"chocolate", :price=>3.1}, {:name=>"soda", :price=>2.5}, {:name=>"sandwich", :price=>4.0}])
  end
end
