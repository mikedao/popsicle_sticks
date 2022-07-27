class StudentsController < ApplicationController
  def new
    @mod_id = params[:id]
  end

  def create
    if (!params[:collection_names].nil? && params[:collection_names] != "" ) &&
       (!params[:collection_pronouns].nil? && params[:collection_pronouns] != "")
      names = params[:collection_names].split("\n")
      pronouns = params[:collection_pronouns].split("\n")

      names.count.times do |n|
        Student.create( 
          name: names[n],
          pronouns: pronouns[n],
          called_on_count: 0,
          mod_id: params[:id]
        )
      end
    else
      Student.create( 
                    name: params[:name],
                    pronouns: params[:pronouns],
                    called_on_count: 0,
                    mod_id: params[:id]
                  )
    end

    redirect_to mod_path(params[:id])
  end

  def destroy_all
    mod_id = params[:id]
    Student.where(mod_id: mod_id).destroy_all

    redirect_to mod_path(mod_id)
  end


  def destroy
    student = Student.find(params[:id])
    mod = student.mod.id
    student.destroy
    redirect_to mod_path(mod)
  end
 
  def edit 
    @student = Student.find(params[:id])
  end 

  def update 
    student = Student.find(params[:id])
    student.update(
                  name: params[:name], 
                  pronouns: params[:pronouns]
                )
    redirect_to "/mods/#{student.mod_id}"
  end 

  def repeat_student
    student = Student.find(params[:id])
    current_set_mod = student.mod.number.to_i
    new_mod = current_set_mod - 1
    if student.mod.number.to_i > 1
      student.update(mod_id: new_mod.to_s)
      flash[:success] = "#{student.name} has been moved to #{student.mod.program} Mod #{new_mod}."
    else  
      flash[:info] = "You can only repeat students who are currently set to Mods 2, 3, or 4."
    end 
    redirect_to "/mods/#{current_set_mod}"
  end 



end