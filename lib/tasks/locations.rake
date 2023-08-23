require 'json'

namespace :locations do

  state_file = File.read('./data/brazil_states.json')
  city_file  = File.read('./data/brazil_cities.json')

  desc 'Update States in Brazil through the ibge.gov.br API'
  task update_states: :environment do
    states = JSON.parse(state_file)
    puts "Início: #{states.count}"

    states.each.with_index(1) do |state, index|
      State.create(external_id: state['id'], uf: state['sigla'], name: state['nome'])
      puts "#{index} #{state['nome']}"
    end

    puts 'Fim'
  end

  desc 'Update Cities in Brazil through the ibge.gov.br API'
  task update_cities: :environment do
    cities = JSON.parse(city_file)

    puts "Início: #{cities.count}"

    cities.each.with_index(1) do |city, index|
      state_uf = city['regiao-imediata']['regiao-intermediaria']['UF']['sigla']
      City.create(external_id: city['id'], name: city['nome'], state: State.find_by(uf: state_uf))

      puts "#{index} #{city['nome']}"
    end

    puts 'Fim'
  end

end
