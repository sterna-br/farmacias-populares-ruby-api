# encoding: UTF-8

require 'grape'
require 'api/v1/farmacia'
require 'model/farmacia'

module API

  module V1

    class Base < Grape::API
      version 'v1', :using => :header, :vendor => 'serpro', :format => :json

      mount API::V1::Farmacia => '/'
    end

  end

end
