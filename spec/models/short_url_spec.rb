# == Schema Information
#
# Table name: short_urls
#
#  id             :bigint           not null, primary key
#  url            :string
#  visits_counter :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  encoded_id     :string
#
# Indexes
#
#  index_short_urls_on_encoded_id  (encoded_id) UNIQUE
#

require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_uniqueness_of(:encoded_id).case_insensitive }
  end

  describe 'encoded_id creation' do
    let(:short_url_attributes) { FactoryBot.attributes_for(:short_url) }

    it 'generate and save a base36 string from id' do
      short_url = described_class.new(short_url_attributes)
      expect(short_url.encoded_id).to be_nil
      short_url.save
      expect(short_url.encoded_id).to eq(short_url.id.to_s(36))
    end
  end

  describe 'increment_visits_counter!' do
    let(:short_url) { FactoryBot.create(:short_url) }
    
    it 'add one more visit to counter' do
      expect {
        short_url.increment_visits_counter!
      }.to change(short_url, :visits_counter).by(1)
    end
  end
end
