class ExpansionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_required, :only => [:new,:edit,:create,:update,:destroy]
  # GET /expansions
  # GET /expansions.json
  def index
    @expansions = Expansion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expansions }
    end
  end

  # GET /expansions/1
  # GET /expansions/1.json
  def show
    @expansion = Expansion.find(params[:id])
    if params[:login].nil?
      @user = current_user
    else
      @user = User.find_by_login(params[:login])
    end
    
    @card = Card.new
    @card.expansion = @expansion
    
    @others = []
    User.all.each{|usr| @others << usr unless usr.id == @user.id }

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expansion }
    end
  end

  # GET /expansions/new
  # GET /expansions/new.json
  def new
    @expansion = Expansion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expansion }
    end
  end

  # GET /expansions/1/edit
  def edit
    @expansion = Expansion.find(params[:id])
  end

  # POST /expansions
  # POST /expansions.json
  def create
    @expansion = Expansion.new(params[:expansion])

    respond_to do |format|
      if @expansion.save
        format.html { redirect_to @expansion, notice: 'Expansion was successfully created.' }
        format.json { render json: @expansion, status: :created, location: @expansion }
      else
        format.html { render action: "new" }
        format.json { render json: @expansion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expansions/1
  # PUT /expansions/1.json
  def update
    @expansion = Expansion.find(params[:id])

    respond_to do |format|
      if @expansion.update_attributes(params[:expansion])
        format.html { redirect_to @expansion, notice: 'Expansion was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @expansion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expansions/1
  # DELETE /expansions/1.json
  def destroy
    @expansion = Expansion.find(params[:id])
    @expansion.destroy

    respond_to do |format|
      format.html { redirect_to expansions_url }
      format.json { head :ok }
    end
  end
end
