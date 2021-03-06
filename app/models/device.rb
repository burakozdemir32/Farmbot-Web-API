# FarmbotDevice models all data related to an actual FarmBot in the real world.
# This is useful for caching things like owner info, work logs, etc
class Device < ActiveRecord::Base
  has_many :users
  has_many :schedules, dependent: :destroy
  has_many :sequences, dependent: :destroy
  has_many :regimens, dependent: :destroy
  has_many :plants, dependent: :destroy
  has_one  :planting_area, dependent: :destroy

  validates_uniqueness_of :name
end
