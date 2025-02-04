class DayMarkingsController < ApplicationController
  before_action :authenticate_user!
  
  def toggle
    date = Date.parse(params[:date])
    marking = current_user.day_markings.find_by(marked_on: date)
    
    if marking
      marking.destroy
    else
      current_user.day_markings.create(marked_on: date)
    end

    # Dopo aver modificato le marcature, ricalcola l'HTML della sezione "markings"
    # Puoi renderizzare un partial (che creiamo nel prossimo punto) e restituirlo come stringa
    markings_html = render_to_string(partial: 'calendars/markings', locals: { date: date, day_markings: @day_markings })
    render json: { html: markings_html }
  end
end
