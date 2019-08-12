require 'rails_helper'

RSpec.describe RedirectsController, type: :controller do
  describe 'GET #show' do
    context 'when encoded_id exists' do
      let!(:short_url) { FactoryBot.create(:short_url) }
      
      it 'return http status found' do
        get :show, params: { id: short_url.encoded_id }  
        expect(response).to have_http_status(:found)
      end

      it 'redirect to correct address' do
        get :show, params: { id: short_url.encoded_id }  
        expect(response).to redirect_to(short_url.url)
      end

      it 'increment short_url visits_counter by 1' do
        expect {
          get :show, params: { id: short_url.encoded_id }  
          short_url.reload
        }.to change(short_url, :visits_counter).by(1)
      end
    end

    context 'when encoded_id do not exists' do
      it 'return http status not found' do
        get :show, params: {id: -9999}
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
