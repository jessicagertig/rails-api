require 'rails_helper'

RSpec.describe '/articles routes' do
  it 'routes to articles#index' do
    # expect(get '/articles').to route_to(controller: 'articles', action: 'index')
    # the above comment on line 5 is equivalent to line 8
    aggregate_failures do
      expect(get '/articles').to route_to('articles#index')
      expect(get '/articles?page[number]=3').to route_to('articles#index', page: [ number: 3])
    end
  end
end
