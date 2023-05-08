# Note: Feel free to leave this class as-is unless modifications are required
# for the rest of your solution, in which case change whatever you'd like.

class VehiclePromotionService
  def self.create_ad(ad_text)
    raise "ad_text must be a String!" unless ad_text.is_a?(String)

    # Pretend we're making a request to an external service :)
    # Commented out for now. this service should be pushed to a job queue such as sidekiq!
    # sleep(3)

    charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
    Array.new(30) { charset.sample }.join
  end

  def self.update_ad(ad_id, ad_text)
    raise "ad_id must be 30 characters long!" unless ad_id.is_a?(String) && ad_id.length == 30
    raise "ad_text must be a String!" unless ad_text.is_a?(String)

    # Pretend we're making a request to an external service :)
    # Commented out for now. this service should be pushed to a job queue such as sidekiq!
    # sleep(3)

    ad_id
  end
end
