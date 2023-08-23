require 'rails_helper'

RSpec.describe Address, type: :model do
  state = State.new(external_id: '0001', uf: 'SP', name: 'São Paulo')
  city = City.new(state: state, external_id: '0001', name: 'São Paulo')
  full_address = Address.new(state: state, city: city, neighborhood: 'Teste', street: 'Teste', zip_code: '00000000')

  it "is valid with valid attributes" do
    expect(full_address).to be_valid
  end

  it "is not valid without a state" do
    address = Address.new(city: city, neighborhood: 'Teste', street: 'Teste', zip_code: '00000000')
    expect(address).to_not be_valid
  end

  it "is not valid without a city" do
    address = Address.new(state: state, neighborhood: 'Teste', street: 'Teste', zip_code: '00000000')
    expect(address).to_not be_valid
  end

  it "is not valid without a neighborhood" do
    address = Address.new(state: state, city: city, street: 'Teste', zip_code: '00000000')
    expect(address).to_not be_valid
  end

  it "is not valid without a street" do
    address = Address.new(state: state, city: city, neighborhood: 'Teste', zip_code: '00000000')
    expect(address).to_not be_valid
  end

  it "is not valid without a zip_code" do
    address = Address.new(state: state, city: city, neighborhood: 'Teste', street: 'Teste')
    expect(address).to_not be_valid
  end

  it "is not valid with duplicate zip_code" do
    full_address.save
    address = Address.new(state: state, city: city, neighborhood: 'TesteB', street: 'TesteB', zip_code: '00000000')
    expect(address).to_not be_valid
  end

  it "full_address" do
    full_adress_string = "Teste - Teste, São Paulo - SP, 00000000"
    expect(full_address.full_address).to eq(full_adress_string)
  end
end
