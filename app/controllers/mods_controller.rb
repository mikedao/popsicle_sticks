class ModsController < ApplicationController
  def index
    @mods = Mod.all
  end

  def show
    @mod = Mod.find(params[:id])
  end

  def lucky
    if params[:weighted] == true
      @student = Student.random_weighted
    else
      mod = Mod.find(params[:id])
      @student = mod.students.enabled.order(Arel.sql('RANDOM()')).first
      @student.increment!(:called_on_count)
    end
  end
end