require 'rails_helper'
RSpec.describe GetWebsiteTitleWorker, type: :worker do
  describe '#perform' do
    let!(:short_url) { FactoryBot.create(:short_url, url: 'https://google.com') }
    let(:worker) { GetWebsiteTitleWorker.new }

    context 'when page has title' do
      it 'get title from url and save on short url' do
        worker.perform(short_url.id)
        short_url.reload
        expect(short_url.title).to eq('Google')
      end
    end

    context 'when page do not have title' do
      it 'leave title empty'
    end
  end
end
