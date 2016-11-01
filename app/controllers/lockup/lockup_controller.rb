module Lockup
  class LockupController < Lockup::ApplicationController
    if self.respond_to?(:skip_before_action)
      skip_before_action :check_for_lockup
    else
      skip_before_filter :check_for_lockup
    end

    def unlock
      if params[:lockup_codeword].present?
        user_agent = request.env['HTTP_USER_AGENT'].downcase
        unless user_agent.match(/crawl|googlebot|slurp|spider|bingbot|tracker|click|parser|spider/)
          @codeword = params[:lockup_codeword].to_s.downcase
          @return_to = params[:return_to]
          if @codeword == lockup_codeword
            set_cookie
            run_redirect
          else
            @wrong = true
          end
        else
          head :ok
        end
      elsif request.post?
        if params[:lockup].present? && params[:lockup].respond_to?(:'[]')
          @codeword = params[:lockup][:codeword].to_s.downcase
          @return_to = params[:lockup][:return_to]
          password_array_string = Rails.application.secrets.password_array_string || ENV["PASSWORD_ARRAY_STRING"]
          password_array = password_array_string.split(",")
          if password_array.include? @codeword
            puts "--------------"
            puts "--------------"
            puts "--------------"
            puts "--------------"
            puts "--------------"
            puts "--------------"
            puts "--------------"
            puts "--------------"
            puts "--------------"
            puts "--------------"
            puts "--------------"
          end

          if @codeword == lockup_codeword
            set_cookie
            run_redirect
          else
            @wrong = true
          end
        else
          head :ok
        end
      else
        respond_to :html
      end
    end

    private

    def set_cookie
      cookies[:lockup] = { value: @codeword.to_s.downcase, expires: (Time.now + 5.years) }
    end

    def run_redirect
      if @return_to.present?
        redirect_to "#{@return_to}"
      else
        redirect_to '/'
      end
    end

  end
end
