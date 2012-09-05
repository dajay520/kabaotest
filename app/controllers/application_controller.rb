class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :getMenuList
  
  def getMenuList
    session[:menuList]=[]
    Interface.all.each do |inter|
      session[:menuList]<<{'id'=>inter.id,'name_cn'=>inter.name_cn}
    end
  end
end
