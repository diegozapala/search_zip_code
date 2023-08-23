require 'rails_helper'

RSpec.describe City, type: :model do
  state = State.new(external_id: '0001', uf: 'SP', name: 'São Paulo')

  it "is valid with valid attributes" do
    city = City.new(state: state, external_id: '0001', name: 'São Paulo')
    expect(city).to be_valid
  end

  it "is not valid without a state" do
    city = City.new(external_id: '0001', name: 'São Paulo')
    expect(city).to_not be_valid
  end

  it "is not valid without a external_id" do
    city = City.new(state: state, name: 'São Paulo')
    expect(city).to_not be_valid
  end

  it "is not valid without a name" do
    city = City.new(state: state, external_id: '0001')
    expect(city).to_not be_valid
  end

  it "is not valid with duplicate external_id" do
    City.create(state: state, external_id: '0001', name: 'São Paulo')
    city = City.new(state: state, external_id: '0001', name: 'São Caetano do Sul')
    expect(city).to_not be_valid
  end
end
