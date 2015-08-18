require 'mongo_mapper'
require 'geocoder'

module Model

  class Farmacia
    include MongoMapper::Document

    MAX_TOTAL = 50

    set_collection_name "farmacia"

    key :coordinates, Array
    key :telefone, String
    key :cep, String
    key :endereco, String
    key :numero, String
    key :cidade, String
    key :uf, String

    def self.nearest(coords, distance, quantity)
      where(:coordinates => {'$near' => coords, '$maxDistance' => distance/111.12}).limit(quantity || MAX_TOTAL)
    end

    def self.by_state(state)
      where(:uf => state).limit(50)
    end

    def self.statistics
      %w(AC AL AM AP BA CE DF ES GO MA MT MS MG PA PB PR PE PI RJ RN RS RO RR SC SP SE TO)
          .map { |state| state_stats state }
          .sort_by { |farmacia| -farmacia[:total] }
    end

    def self.state_stats(state)
      {:name => state, :total => where(:uf => state).count}
    end

  end

end