class DayMarkingsController < ApplicationController
  before_action :authenticate_user!
  
  def toggle
    # Azione per l’utente normale: opera sulle proprie marcature
    date = Date.parse(params[:date])
    marking = current_user.day_markings.find_by(marked_on: date)
    
    if marking
      marking.destroy
    else
      current_user.day_markings.create(marked_on: date)
    end

    respond_to do |format|
      format.js   # toggle.js.erb per aggiornare dinamicamente la vista
      format.html { redirect_to calendars_path }
    end
  end

  def admin_toggle
    # Questa azione permette all’admin di operare sulle marcature di altri utenti.
    unless current_user.admin?
      redirect_to calendars_path, alert: "Accesso non autorizzato" and return
    end

    # L’admin invia anche il parametro user_id per specificare su chi agire.
    user = User.find(params[:user_id])
    date = Date.parse(params[:date])
    marking = DayMarking.find_by(user: user, marked_on: date)

    if marking
      marking.destroy
    else
      DayMarking.create(user: user, marked_on: date)
    end

    respond_to do |format|
      format.js   # admin_toggle.js.erb per aggiornare dinamicamente la vista se usi AJAX
      format.html { redirect_to calendars_path }
    end
  end
end
