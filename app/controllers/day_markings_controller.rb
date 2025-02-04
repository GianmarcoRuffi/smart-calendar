class DayMarkingsController < ApplicationController
  before_action :authenticate_user!
  
  def toggle
    # Ricevi la data dal parametro, ad esempio in formato ISO (YYYY-MM-DD)
    date = Date.parse(params[:date])
    
    # Se l'utente ha già segnato quel giorno, elimina la marcatura
    marking = current_user.day_markings.find_by(marked_on: date)
    if marking
      marking.destroy
    else
      current_user.day_markings.create(marked_on: date)
    end

    # Per AJAX, puoi restituire (ad esempio) un JSON oppure reindirizzare
    respond_to do |format|
      format.js   # toggle.js.erb per aggiornare dinamicamente la vista
      format.html { redirect_to calendars_path }
    end
  end
end
