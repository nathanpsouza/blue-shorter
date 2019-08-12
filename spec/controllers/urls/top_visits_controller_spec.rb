require 'rails_helper'

RSpec.describe Urls::TopVisitsController, type: :controller do
  describe 'GET #index' do
    let!(:short_urls) { FactoryBot.create_list(:short_url, 110) }

    it 'return http status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'order urls by visits counter descending' do
      first = FactoryBot.create(:short_url, visits_counter: 10003)
      second = FactoryBot.create(:short_url, visits_counter: 10002)
      third = FactoryBot.create(:short_url, visits_counter: 10001)

      get :index, params: { limit: 3 }
      json = JSON.parse(response.body)
      
      expect(json[0]['url']).to eq(first.url)
      expect(json[1]['url']).to eq(second.url)
      expect(json[2]['url']).to eq(third.url)
    end

    context 'with limit param' do
      it 'return the number of specified urls' do
        get :index, params: { limit: 20 }
        json = JSON.parse(response.body)
        expect(json.size).to eq(20)
      end
    end

    context 'without limit param' do
      it 'return default number of urls (100)' do
        get :index
        json = JSON.parse(response.body)
        expect(json.size).to eq(100)
      end
    end
  end
end
