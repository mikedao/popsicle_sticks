class ModsController < ApplicationController
  def index
    @mods = Mod.all
  end

  def show
    @mod = Mod.find(params[:id])
  end
end