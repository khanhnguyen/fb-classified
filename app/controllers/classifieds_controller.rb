class ClassifiedsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :login, :show]

  def index
  end

  def show
    @classified = Classified.find(params[:id])
    # save activity
    if current_user and current_user.id != @classified.user.id  
      @classified.activities.create( :user_id => current_user.id, :a_type => "show_classified" )
    end  
  end

  def new
    @classified = Classified.new
    5.times { @classified.photos.build } 
  end

  def create
    @classified = current_user.classifieds.build(params[:classified])

    #Set expires_at to 30 days from now
    @classified.expires_at = Time.now.advance(:months => 1)

    if @classified.save
      redirect_to @classified, notice: 'Classified was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
    @classified = Classified.find(params[:id])
    5.times { @classified.photos.build }
    can_modify?(@classified)
  end

  def update
    @classified = Classified.find(params[:id])
    can_modify?(@classified)

    if @classified.update_attributes(params[:classified])
      respond_to do |format|
        format.html {redirect_to @classified, notice: 'Classified was successfully updated.'}
        format.js { head :ok }
      end
    else
      render action: "edit"
    end
  end
end
