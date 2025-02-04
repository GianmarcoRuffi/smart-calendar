class CalendarsController < ApplicationController
  before_action :authenticate_user! 

  def index
    @year = Date.today.year
    @day_markings = DayMarking.where(marked_on: Date.new(@year,1,1)..Date.new(@year,12,31))
  end
end
