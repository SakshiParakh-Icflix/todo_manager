module Trackable
  extend ActiveSupport::Concern

  def update_tracked_fields
    old_current, new_current = self.current_signin_at, DateTime.now.utc
    self.last_signin_at     = old_current || new_current
    self.current_signin_at  = new_current

    self.sign_in_count ||= 0
    self.sign_in_count += 1
  end
end
