class RelationsController < ApplicationController
  
  def index
    @record = params[:type].constantize.find(params[:id])
    @related_records = @record.send("related_#{params[:relation].downcase.pluralize}")

    respond_to do |format|
      format.js {render :layout => false}
    end
  end  
end
