class HomeController < ApplicationController
  http_basic_authenticate_with name: "", password: "password", only: [:admin]

  def home
  end

  def admin
  end
end
