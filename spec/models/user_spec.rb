require 'rails_helper'

RSpec.describe User, type: :model do
  full_user = User.new(name: 'João', last_name: 'Silva', email: 'joao.silva@teste.com', password: '123456')

  it "is valid with valid attributes" do
    expect(full_user).to be_valid
  end

  it "is not valid without a name" do
    user = User.new(last_name: 'Silva', email: 'joao.silva@teste.com', password: '123456')
    expect(user).to_not be_valid
  end

  it "is not valid without a last name" do
    user = User.new(last_name: 'Silva', email: 'joao.silva@teste.com', password: '123456')
    expect(user).to_not be_valid
  end

  it "is not valid without a email" do
    user = User.new(name: 'João', last_name: 'Silva', password: '123456')
    expect(user).to_not be_valid
  end

  it "is not valid without a password" do
    user = User.new(name: 'João', last_name: 'Silva', email: 'joao.silva@teste.com')
    expect(user).to_not be_valid
  end

  it "is not valid with duplicate email" do
    full_user.save
    user = User.new(name: 'José', last_name: 'Santos', email: 'joao.silva@teste.com', password: '654321')
    expect(user).to_not be_valid
  end

  it "set_default_params" do
    full_user.email = ' JoaO.sILVA@teste .com '
    full_user.save
    expect(full_user.email).to eq('joao.silva@teste.com')
  end

  it "Only active" do
    User.create(name: 'João', last_name: 'Silva', email: 'joao.active@teste.com', password: '123456', active: true)
    User.create(name: 'João', last_name: 'Silva', email: 'joao.inactive@teste.com', password: '123456', active: false)

    expect(User.active.count).to eq(1)
    expect(User.active.first.email).to eq('joao.active@teste.com')
  end

  it "Only inactive" do
    User.create(name: 'João', last_name: 'Silva', email: 'joao.active@teste.com', password: '123456', active: true)
    User.create(name: 'João', last_name: 'Silva', email: 'joao.inactive@teste.com', password: '123456', active: false)

    expect(User.inactive.count).to eq(1)
    expect(User.inactive.first.email).to eq('joao.inactive@teste.com')
  end

  it "full_name" do
    full_name = "João Silva"
    expect(full_user.full_name).to eq(full_name)
  end

  it "name_initials" do
    name_initials = "JS"
    expect(full_user.name_initials).to eq(name_initials)
  end
end
