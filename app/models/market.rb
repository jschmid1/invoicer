class Market < ActiveRecord::Base
  # belongs_to :bill ? why not ?
  validates :name, presence: true
end
