class HomeController < ApplicationController
  http_basic_authenticate_with name: "", password: "yeet", only: [:admin]

  def home
    @frontrunners = Restaurant.where(id: Survey.top_contenders.first)
  end

  def admin
  end
end
