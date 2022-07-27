class StudentsController < ApplicationController
  def new
    @mod_id = params[:id]
  end

  def create
    Student.create( 
                  name: params[:name],
                  pronouns: params[:pronouns],
                  called_on_count: 0,
                  mod_id: params[:id]
                )
    redirect_to mod_path(params[:id])
  end


end