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

class ShortUrl < ApplicationRecord
  validates :url, presence: true
  validates :encoded_id, uniqueness: { case_sensitive: false }

  after_create :encode_id

  private

  def encode_id
    update_attribute(:encoded_id, id.to_s(36))
  end
end
