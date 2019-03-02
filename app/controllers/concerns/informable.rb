module Informable
  extend ActiveSupport::Concern

  #----------------------------------
  # Get Remote IP Information
  # args: none, returns: string
  #----------------------------------
  def get_remote_ip
    remote_ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip # For Apache and/or Nginx
  end
end
