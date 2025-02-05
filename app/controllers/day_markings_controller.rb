class DayMarkingsController < ApplicationController
  before_action :authenticate_user!

  def toggle
    date = Date.parse(params[:date])

    # Crea o distrugge la marcatura
    marking = current_user.day_markings.find_by(marked_on: date)
    if marking
      marking.destroy
    else
      current_user.day_markings.create(marked_on: date)
    end

    # Recupera le marcature per il giorno
    @day_markings = DayMarking.all

    # Risponde con il nuovo stato delle marcature in formato JSON
    respond_to do |format|
      format.json { render json: { html: render_to_string(partial: 'calendars/markings', locals: { date: date }) } }
    end
  end
end
