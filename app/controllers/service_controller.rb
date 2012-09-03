class ServiceController < ApplicationController
  
  def process(met)
    i = Interface.find_by_name_en params[:method]
    if i
      
      i.condition_paramss.each do |cp|
        
        if cp.in
          begin
            flag=true
            ActiveSupport::JSON.decode(cp.in).each_pair do |k,v|
              if params[k]!=v
                flag=false
                break;
              end
            end
            if flag
              @cpout = cp.out 
              render :process
              return
            end
          rescue MultiJson::DecodeError
          end
          
        end
      end
    end
  render :process
  end
end
