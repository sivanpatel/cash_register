## Cash Register

An implementation of a Cash Register and Cart system, which has specific rules for
giving discounts provided different conditions are met.

The file structure is as follow:
```
.
├── Gemfile
├── Gemfile.lock
├── README.md
├── lib
│   ├── cart.rb
│   ├── discount_rules.rb
│   ├── products.rb
│   ├── products.yml
│   └── register.rb
└── spec
    ├── cart_spec.rb
    ├── products_spec.rb
    ├── register_spec.rb
    └── spec_helper.rb
```

The Cart class contains logic for creating a cart, and adding and removing products from it.

The Register class contains a method for calculating the price of the items within a
given cart, as well as finding the price of products. It is purposefully kept simple
and give it as few responsibilities as possible. When adding new discount rules, all that
need to be changed in here is the method `apply_discounts` with a new line with the new rule
and application (which is to be defined in the DiscountRules module).

The DiscountRules module contains the rules for when and how discounts are applied to products
in the given basket. They have been put here and included in the Register class. This is to
not make the Register class too large. In here, to add new discount rules two methods are needed:
one to check whether the discount rules are met (which returns true or false), and one which applies
the discount itself and calculates the price of the products as well as updating the quantity of products
left to price.

The Products class contains a methods to populate an array of products from a given yaml file.
A yaml file was chosen for listing the products as it allows you to quickly and easily add
new products. It will also be easy to add new attributes to the products if needed (for example
quantity in stock).

To run the tests, in the root directory:
```
$ rspec
```

To run the program, in the root directory:
```
$ irb
$ require './lib/cart.rb'
$ require './lib/register.rb'
$ cart = Cart.add_products_to_cart("beer", "beer", "chocolate")
$ register = Register.new(cart)
$ register.total_price
```
