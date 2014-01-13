class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :set_locale, :set_debug
 
  def set_locale
    # I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = 'es-AR'
  end

  def set_debug
    @debugs = []
  end

end
