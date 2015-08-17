require File.expand_path('../config/environment', __FILE__)

MongoMapper.setup({'development' => {'uri' => 'mongodb://localhost'}}, 'development')
MongoMapper.database = 'farmaciaspopulares'
Model::Farmacia.ensure_index [[:coordinates, '2d']]

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options, :patch]
  end
end

run API::Base