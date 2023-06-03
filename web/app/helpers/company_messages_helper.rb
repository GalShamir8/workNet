# frozen_string_literal: true

# CompanyMessagesHelper
module CompanyMessagesHelper
  def time_options = %w[minutes hours days weeks months]

  def expired_icon(company_message)
    tool_tip = "This message will disaper in #{distance_of_time_in_words(company_message.expires_in - Time.now)}"
    "<i class='glyphicon glyphicon-hourglass' title='#{tool_tip}'></i>".html_safe
  end
end
