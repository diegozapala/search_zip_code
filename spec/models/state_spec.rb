require 'rails_helper'

RSpec.describe State, type: :model do
  it "is valid with valid attributes" do
    state = State.new(external_id: '0001', uf: 'SP', name: 'São Paulo')
    expect(state).to be_valid
  end

  it "is not valid without a external_id" do
    state = State.new(uf: 'SP', name: 'São Paulo')
    expect(state).to_not be_valid
  end

  it "is not valid without a uf" do
    state = State.new(external_id: '0001', name: 'São Paulo')
    expect(state).to_not be_valid
  end

  it "is not valid without a name" do
    state = State.new(external_id: '0001', uf: 'SP')
    expect(state).to_not be_valid
  end

  it "is not valid with duplicate external_id" do
    State.create(external_id: '0001', uf: 'SP', name: 'São Paulo')
    state = State.new(external_id: '0001', uf: 'RJ', name: 'Rio de Janeiro')
    expect(state).to_not be_valid
  end
end
