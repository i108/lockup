module Lockup
  module LockupHelper

    def lockup_hint_present?
      if ENV["LOCKUP_HINT"].present? || ENV["lockup_hint"].present? || ((Rails::VERSION::MAJOR >= 5 && Rails::VERSION::MINOR >= 2) && Rails.application.credentials[:lockup_hint].present?)
        true
      else
        false
      end
    end

    def lockup_hint_display
      if ENV["LOCKUP_HINT"].present?
        ENV["LOCKUP_HINT"].to_s
      elsif ENV["lockup_hint"].present?
        ENV["lockup_hint"].to_s
      elsif (Rails::VERSION::MAJOR >= 5 && Rails::VERSION::MINOR >= 2) && Rails.application.credentials[:lockup_hint].present?
        Rails.application.credentials.lockup_hint.to_s
      end
    end

  end
end
