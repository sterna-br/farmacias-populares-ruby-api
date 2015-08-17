require 'grape'
require 'model/farmacia'
require 'api/v1/entity/farmacia'
require 'api/v1/entity/error'

module API

  module V1

    class Farmacia < Grape::API
      format :json

      resources :farmacias do

        desc 'Listar as farmácias próximas ao ponto informado.'
        params do
          optional :state, type: String
          requires :latitude, type: Float
          requires :longitude, type: Float
          requires :distance, type: Integer
        end
        get do
          if params[:state].nil? || params[:state].empty?
            result = Model::Farmacia.nearest [params[:longitude], params[:latitude]], params[:distance]
          else
            result = Model::Farmacia.by_state params[:state]
          end

          present result
        end

        desc 'Obter as estatísticas contendo a quantidade de farmácias em cada estado brasileiro.'
        get 'statistics' do
          present Model::Farmacia.statistics
        end

      end

    end

  end

end