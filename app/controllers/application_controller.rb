class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :getMenuList
  
  def getMenuList
    session[:menuList] = Interface.all
  end
end
