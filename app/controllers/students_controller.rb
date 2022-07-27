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



end