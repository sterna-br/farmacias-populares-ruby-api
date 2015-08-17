# encoding: utf-8

require 'grape-entity'

module Entity

  class Farmacia < Grape::Entity
    expose :latitude
    expose :longitude
    expose :ddd
    expose :telefone
    expose :cep
    expose :endereco
    expose :numero
    expose :cidade
    expose :uf
  end

end