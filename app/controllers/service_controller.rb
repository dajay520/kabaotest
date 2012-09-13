#encoding: UTF-8
require 'iconv'
class ServiceController < ApplicationController
  def process(met)
    
    
    response.headers["Content-Type"] = "text/html; charset=gbk" 
    i = Interface.find_by_name_en params[:method]
    if i
      
      log_it i.id,'接收' +  request.request_method_symbol.to_s + '请求:' + request.url 
      if request.post?
        log_it i.id,'post请求参数:' + request.body.to_s
      end
      ncp=nil
      i.condition_paramss.each do |cp|
        flag=true
        if cp.status == '-1'
          next
        end
        if cp.in and cp.in.strip != ''
          begin
            ActiveSupport::JSON.decode(cp.in).each_pair do |k,v|
              if params[k]!=v
              flag=false
              break;
              end
            end
          rescue MultiJson::DecodeError
          end
          if flag
            log_it i.id,'匹配到条件:' + cp.in + '，已响应。返回内容参见条件名称:'+cp.name 
            @cpout = to_gbk cp.out
            render :text=>@cpout
          return
          end
        else
          ncp=cp
        end

      end
      #如果接口走到这说明没有匹配到条件，那么如果存在默认返回值则返回默认值
      if ncp
        log_it i.id,'未匹配到任何条件，已使用默认响应。'
        render :text=>to_gbk(ncp.out)
      return
      end
      #
      log_it i.id,'没有匹配到任何条件。'
      render :text=>to_gbk('没有匹配到任何条件')
    return
    else
      log_it nil,'接口不存在'
      render :text=>to_gbk('接口不存在')
    return
    end

  end
  
  
  def log_it(id,logs)
    log = Logs.new
    log.interface_id=id
    log.logs=logs
    log.save
  end

   def to_gbk(str)
     Iconv.conv("gbk//IGNORE","UTF-8//IGNORE",str)
   end
   
   def to_utf8(str)
     Iconv.conv("UTF-8//IGNORE","gbk//IGNORE",str)
   end
   
  def test
    render :process
  end
end
