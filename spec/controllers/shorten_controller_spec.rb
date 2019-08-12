require 'rails_helper'

RSpec.describe ShortenController, type: :controller do
  describe 'POST #create' do
    let(:payload) { { url: 'https://foo.bar' } }
    let(:json) { { short_url: payload }.to_json }

    context 'with valid url' do
      it 'create short url on database' do
        expect {
          post :create, body: json, format: :json
        }.to change(ShortUrl, :count).by(1) 
      end
  
      it 'return http status created' do
        post :create, body: json, format: :json
        expect(response).to have_http_status(:created)
      end
  
      it 'return short url on json' do
        post :create, body: json, format: :json
        parsed_json = JSON.parse(response.body)
        url = redirect_to_short_url(ShortUrl.last.encoded_id)
        expect(parsed_json["short_url"]).to eq(url)
      end

      it 'enqueue job to get website title' do
        expect {
          post :create, body: json, format: :json
        }.to change(GetWebsiteTitleWorker.jobs, :size ).by(1)
      end
    end

    context 'with invalid url' do
      let(:payload) { { url: '' } }
      it 'return http status unprocessable entity' do
        post :create, body: json, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'return errors on json' do
        post :create, body: json, format: :json
        parsed_json = JSON.parse(response.body)
        expect(parsed_json["errors"]).to_not be_empty
      end

      it 'do not save url on database' do
        expect {
          post :create, body: json, format: :json
        }.to_not change(ShortUrl, :count)
      end
    end
  end
end
