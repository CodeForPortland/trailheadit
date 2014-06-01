class TrailheadsController < ApplicationController
  before_action :set_trailhead, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:post]

  def email

    # process various message parameters:
    @sender  = params['from']
    @subject = params['subject']

    # get the "stripped" body of the message, i.e. without
    # the quoted part
    @actual_body = params["stripped-text"]

    # process all attachments:
    count = params['attachment-count'].to_i
    count.times do |i|
      stream = params["attachment-#{i+1}"]
      filename = stream.original_filename
      data = stream.read()
      # now data needs to be parsed for lat lng and then attached to the carrier wave uploader
    end     
    
    # Trailhead.create(name:@subject, email:@sender)
  end

  # GET /trailheads
  # GET /trailheads.json
  def index
    @trailheads = Trailhead.all
  end

  # GET /trailheads/1
  # GET /trailheads/1.json
  def show
  end

  # GET /trailheads/new
  def new
    @trailhead = Trailhead.new
  end

  # GET /trailheads/1/edit
  def edit
  end

  # POST /trailheads
  # POST /trailheads.json
  def create
    @trailhead = Trailhead.new(trailhead_params)

    respond_to do |format|
      if @trailhead.save
        format.html { redirect_to @trailhead, notice: 'Trailhead was successfully created.' }
        format.json { render :show, status: :created, location: @trailhead }
      else
        format.html { render :new }
        format.json { render json: @trailhead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trailheads/1
  # PATCH/PUT /trailheads/1.json
  def update
    respond_to do |format|
      if @trailhead.update(trailhead_params)
        format.html { redirect_to @trailhead, notice: 'Trailhead was successfully updated.' }
        format.json { render :show, status: :ok, location: @trailhead }
      else
        format.html { render :edit }
        format.json { render json: @trailhead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trailheads/1
  # DELETE /trailheads/1.json
  def destroy
    @trailhead.destroy
    respond_to do |format|
      format.html { redirect_to trailheads_url, notice: 'Trailhead was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trailhead
      @trailhead = Trailhead.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trailhead_params
      params.require(:trailhead).permit(:phone_id, :name, :latitude, :longitude, :photo, :parking, :drinking_water, :restrooms, :kiosk)
    end
end
