require 'rails_helper'

RSpec.describe ArticlesController do
  describe '#index' do
    it 'returns a success response' do
      get '/articles'
      # expect(response.status).to eq(200)
      expect(response).to have_http_status(:ok)
    end

    it 'returns a proper JSON response' do
      article = create :article
      get '/articles'
      # body = JSON.parse(response.body).deep_symbolize_keys --> this logic is extracted into a helper which allows usage of json_data in expect(json_data) instead of the defined body AND the data: key is removed
      # pp body ---> this code used to see body in more detail to detect differences
      expect(json_data).to eq(
        [
          {
            id: article.id.to_s,
            type: 'articles',
            attributes: {
              title: article.title,
              content: article.content,
              slug: article.slug
            }
          }
        ]
      )
    end
  end
end