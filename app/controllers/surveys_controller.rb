class SurveysController < ApplicationController
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

  private
  def survey_params
    params[:survey][:response] = params[:survey][:response].join(",") unless params[:survey][:response].class != Array
    params.require(:survey).permit(:participant, :response)
  end
end
