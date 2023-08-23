require 'rails_helper'

RSpec.describe UserAddress, type: :model do
  state = State.new(external_id: '0001', uf: 'SP', name: 'São Paulo')
  city = City.new(state: state, external_id: '0001', name: 'São Paulo')

  user = User.new(name: 'João', last_name: 'Silva', email: 'joao.silva@teste.com', password: '123456')
  address = Address.new(state: state, city: city, neighborhood: 'Teste', street: 'Teste', zip_code: '00000000')

  it "is valid with valid attributes" do
    user_address = UserAddress.new(user: user, address: address)
    expect(user_address).to be_valid
  end

  it "is not valid without a user" do
    user_address = UserAddress.new(address: address)
    expect(user_address).to_not be_valid
  end

  it "is not valid without a address" do
    user_address = UserAddress.new(user: user)
    expect(user_address).to_not be_valid
  end
end
