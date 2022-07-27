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
          mod_id: params[:id],
          enabled: 1
        )
      end
    else
      Student.create( 
                    name: params[:name],
                    pronouns: params[:pronouns],
                    called_on_count: 0,
                    mod_id: params[:id],
                    enabled: 1
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
                  pronouns: params[:pronouns],
                  enabled: params[:enabled]
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

  def promote_all
    b1 = Mod.find_by(program: 'BEE', number: '1')
    b2 = Mod.find_by(program: 'BEE', number: '2')
    b3 = Mod.find_by(program: 'BEE', number: '3')

    f1 = Mod.find_by(program: 'FEE', number: '1')
    f2 = Mod.find_by(program: 'FEE', number: '2')
    f3 = Mod.find_by(program: 'FEE', number: '3')

    c4 = Mod.find_by(program: 'Combined', number: '4')

    # remove all C4 students
    c4.students.destroy_all

    # moves b3 and f3 students to c4
    b3.students.update_all(mod_id: c4.id)
    f3.students.update_all(mod_id: c4.id)

    # moves b2 students to b3
    b2.students.update_all(mod_id: b3.id)
    
    # moves f2 students to f3
    f2.students.update_all(mod_id: f3.id)

    # moves b1 students to b2
    b1.students.update_all(mod_id: b2.id)

    # moves f1 students to f2
    f1.students.update_all(mod_id: f2.id)

    flash[:success] = "Students have been promoted."

    redirect_to root_path
    

  end


end