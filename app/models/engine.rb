class Engine < ApplicationRecord
  belongs_to :vehicle

  DEFAULT_STATUS = 'works'
  ALL_STATUSES = %w(works fixable junk)

  validates :status, inclusion: ALL_STATUSES

  after_initialize :set_defaults

  private

  def set_defaults
    self.status ||= DEFAULT_STATUS
  end
end
