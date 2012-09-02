#encoding: UTF-8
class ConfigController < ApplicationController

def index
	
end

def interface
   session[:selected]=params[:id] 
   session[:m_selected] = nil
   @interface=Interface.find(params[:id])
   @con = @interface.condition_paramss
   
end

def create_condition
  puts params[:in]
   cp = ConditionParams.new
   cp.in=params[:in]
   cp.out=params[:response_value]
   cp.name=params[:condition_name]
   cp.interface_id=params[:id]
   if cp.save
     redirect_to '/config/'+params[:id]
   end
   
end

def del_condition
  ConditionParams.delete params[:id]
  redirect_to '/config/'+params[:interface_id]
end

end
