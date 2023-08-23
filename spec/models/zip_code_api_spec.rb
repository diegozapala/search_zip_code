require 'rails_helper'

RSpec.describe ZipCodeApi, type: :model do
  it "get_address with valid zip code" do
    zip_code = '03088000'
    resp = ZipCodeApi.get_address(zip_code: zip_code)
    expect(resp["cep"]).to eq(zip_code)
  end

  it "get_address with invalid zip code" do
    zip_code = '00000000'
    resp = ZipCodeApi.get_address(zip_code: zip_code)
    expect(resp).to eq([])
  end
end
