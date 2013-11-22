class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_gettext_locale


  protected
    def set_gettext_locale
      requested_locale = params[:locale] || session[:locale] || request.env['HTTP_ACCEPT_LANGUAGE'] || I18n.default_locale
      requested_locale = 'zh_CN' if %w(zh zh-tw zh_tw).include?(requested_locale.downcase)
      requested_locale = 'en_US' if %w(en en-gb en_gb).include?(requested_locale.downcase)
      locale = FastGettext.set_locale(requested_locale)
      I18n.locale = locale
      puts I18n.locale
      session[:locale] = I18n.locale.to_s
    end
end
