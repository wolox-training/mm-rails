module Admin
  class ApplicationController < Administrate::ApplicationController
    http_basic_authenticate_with(
      name: Rails.application.secrets.admin[:name],
      password: Rails.application.secrets.admin[:password]
    )
  end
end
