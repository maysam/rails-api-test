# frozen_string_literal: true

module Expirable
  extend ActiveSupport::Concern

  def expired?
    expiration_date < Time.zone.today
  end
end
