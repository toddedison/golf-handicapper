class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy, :handicap]


  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Round saved!"
      redirect_to current_user
    else
      flash.now[:danger] = "Error saving round!"
      render 'new'
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    if @micropost.present?
       @micropost.destroy
    end
    flash[:success] = "Round deleted!"
    redirect_to current_user
  end


  private ######################################################################

   def micropost_params
     params.require(:micropost).permit(:course, :game_date, :slope, :rating, :score, :handicap)
   end

end
