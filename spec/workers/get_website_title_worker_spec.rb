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
      let(:short_url) { FactoryBot.create(:short_url, url: 'https://gist.githubusercontent.com/nathanpsouza/e0e15dca7f495516f221b97cc223401c/raw/18645bba450dde69ba3e7b1320f45bc62bf140a7/gistfile1.txt') }
      it 'leave title empty' do
        worker.perform(short_url.id)
        short_url.reload
        expect(short_url.title).to be_nil
      end
    end
  end
end
