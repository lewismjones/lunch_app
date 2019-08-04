class SurveysController < ApplicationController
  http_basic_authenticate_with name: "", password: "password", except: [:new, :create]
  before_action :get_surveys, only: [:index, :results]
  before_action :get_restaurants, only: [:new, :create]

  def index
  end

  def show
    @survey = Survey.find(params[:id])
    @restaurants = Restaurant.where(id: @survey.response.split(","))
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)

    if @survey.save
      render 'thanks'
    else
      render 'new'
    end
  end

  def destroy
   @survey = Survey.find(params[:id])
   @survey.destroy

   redirect_to surveys_path
 end

 def results
 end


  private
  def survey_params
    params[:survey][:response] = params[:survey][:response].join(",") unless params[:survey][:response].class != Array
    params.require(:survey).permit(:participant, :response)
  end

  def get_surveys
    @surveys = Survey.today
  end

  def get_restaurants
    @restaurants = Restaurant.alpha_sort
  end
end
