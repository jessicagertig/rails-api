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
      expect(json_data.length).to eq(1)
      expected = json_data.first
      aggregate_failures do
        expect(expected[:id]).to eq(article.id.to_s)
        expect(expected[:type]).to eq('articles')
        expect(expected[:attributes]).to eq(
          title: article.title,
          content: article.content,
          slug: article.slug
        )
      end
      # expect(json_data).to eq(
      #   [
      #     {
      #       id: article.id.to_s,
      #       type: 'articles',
      #       attributes: {
      #         title: article.title,
      #         content: article.content,
      #         slug: article.slug
      #       }
      #     }
      #   ]
      # )
    end

    it 'returns articles in the proper order' do
      older_article = 
        create(:article, created_at: 1.hour.ago)
      recent_article = create(:article)
      get '/articles'
      ids = json_data.map { |item| item[:id].to_i }
      expect(ids).to(
        eq([recent_article.id, older_article.id])
      )
    end

    it 'paginates results' do
      article1, article2, article3 = create_list(:article, 3)
      get '/articles', params: { page: { number: 2, size: 1 } }
      expect(json_data.length).to eq(1)
      expect(json_data.first[:id]).to eq(article2.id.to_s)
    end

    it 'contains pagination links in the response' do
      article1, article2, article3 = create_list(:article, 3)
      get '/articles', params: { page: { number: 2, size: 1 } }
      expect(json[:links].length).to eq(5)
      expect(json[:links].keys).to contain_exactly(
        :first, :prev, :next, :last, :self
      )
    end
  end
end