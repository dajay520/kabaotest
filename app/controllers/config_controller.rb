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

#编辑条件，修改条件参数
def go_to_edit
  @con = ConditionParams.find_by_id params[:id]
  if @con
    render "_edit_condition"
  else
    @error_info="条件不存在或已被删除。"
    render 'common_error'
  end
end

def edit_commit
    cp = ConditionParams.find_by_id params[:id]
    ocp = ConditionParams.where(:interface_id=>cp.interface_id).where(:in=>params[:in]).where("status!='-1' or status is null" )
    if ocp.size>0
      cp.status='-1'
    else
      cp.status='0'
    end
    cp.in=params[:in]
    cp.out=params[:response_value]
    cp.name=params[:condition_name]
    if cp.save
      redirect_to '/config/'+cp.interface_id.to_s
    else
      @error_info="条件保存失败"
      render 'common_error'
    end
    
end

#获取日志
def get_logs
  @logs = Logs.where(:interface_id=>params[:id]).where('id>'+params[:logsid]).order('created_at')
  @logs.each do |l|
    l.logs = l.created_at.strftime('%Y-%m-%d %H:%M:%S')+ "-" + l.logs
  end
  respond_to do |format|
      format.json{ render json: @logs }
    end 
  
end

def show_logs
  @logs = Logs.where(:interface_id=>params[:id]).order('created_at desc').paginate(:page=>1,:per_page=>100).reverse
  @interface=Interface.find(params[:id])
  @maxlogid=0
  if @logs[-1]
    @maxlogid = @logs[-1].id
  end
  render '_logs'
end

def del_logs
  @maxlogid=0
  @interface=Interface.find(params[:id])
  Logs.where(:interface_id=>params[:id]).delete_all
  render '_logs'
end

def show_response
  @cp = ConditionParams.find_by_id params[:id]
  render :text=>@cp.out,:layout=>'show_response'
end

end
