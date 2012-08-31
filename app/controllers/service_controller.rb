class ServiceController < ApplicationController
  
  def process(met)
    
  puts met
  puts params[:method]
  render :process
  end
end
