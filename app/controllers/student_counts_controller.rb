class StudentCountsController < ApplicationController
  def destroy
    Mod.find(params[:id]).students.update_all(called_on_count: 0)
    redirect_to mod_path(params[:id])
  end
end