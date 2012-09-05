#encoding: UTF-8
class ServiceController < ApplicationController
  def process(met)
    i = Interface.find_by_name_en params[:service]
    if i
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
            @cpout = cp.out
            render :text=>@cpout
          return
          end
        else
          ncp=cp
        end

      end
      #如果接口走到这说明没有匹配到条件，那么如果存在默认返回值则返回默认值
      if ncp
        render :text=>ncp.out
      return
      end
      #
      render :text=>'没有匹配到任何条件'
    return
    else
      render :text=>'接口不存在'
    return
    end

  end
end
