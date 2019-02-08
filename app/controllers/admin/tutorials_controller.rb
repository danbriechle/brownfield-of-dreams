class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.create(make_tutorial_params)
    if @tutorial.save
      flash[:notice] = "Successfully created tutorial."
      redirect_to tutorial_path(@tutorial.id)
    else
      @errors = @tutorial.errors
      flash[:notice] = "Incorrect Info"
      render :new
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private
  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def make_tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end
end
