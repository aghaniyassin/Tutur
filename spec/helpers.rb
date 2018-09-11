module Helpers
  def sign_in!(user)
    controller.auto_login(user)
  end

  def self.stub_with(factory_product)
    Geocoder.configure(lookup: :test)

    Geocoder::Lookup::Test.add_stub(
      factory_product.address, [
        {
          'coordinates'  => [factory_product.latitude, factory_product.longitude],
          'address'      => factory_product.address,
          'country'      => 'United States',
          'country_code' => 'US'
        }
      ]
    )
  end
end
