#encoding: UTF-8
class ConfigController < ApplicationController

def index
	
end

  def test
    render 'partnerget.xml'
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
   #当请求参数设置不为空时
   # if params[:in] and params[:in].strip != ''
     # ocp = ConditionParams.where :in=>params[:in],:interface_id=>params[:id]
     # if ocp.size>0
       # @error_info='该请求参数的条件已存在！已存在的条件名称为:' + ocp[0].name
       # render :common_error
       # return 
     # end
   # end
   ocp = ConditionParams.where(:interface_id=>params[:id]).where(:in=>params[:in]).where("status!='-1' or status is null" )
   if ocp.size>0
     cp.status='-1'
   else
     cp.status='0'
   end
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

#修改条件状态，使之生效或者失效。
def mod_condition
  con = ConditionParams.find_by_id params[:id]

  if con
    con.status=params[:status]
    con.save
    #如果是开启操作，那么必须关闭相同条件的状态
    if params[:status]!='-1'
      ConditionParams.where(:interface_id=>con.interface_id).where(:in=>con.in).where("id!=#{con.id}").each do |cp|
        cp.status='-1'
        cp.save
      end
    end
  end
  
  redirect_to '/config/' + params[:interface_id]
end

end
