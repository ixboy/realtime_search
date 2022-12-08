class Search < ApplicationRecord
  validates :query, presence: true
  validates :query, length: { minimum: 3 }
  validates :searcher_id, presence: true

  def searched?(search)
    require 'fuzzystringmatch'
    jarow = FuzzyStringMatch::JaroWinkler.create(:native)
    similarity_percentage = jarow.getDistance(search, query)
    similarity_percentage > 0.8
  end
end
