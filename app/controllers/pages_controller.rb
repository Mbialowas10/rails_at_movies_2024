class PagesController < ApplicationController
  before_action :set_page, only: %i[ show update destroy ]
  http_basic_authenticate_with name: "user", password: "password", except: :show
  # GET /pages or /pages.json
  def index
    @pages = Page.all
  end

  # GET /pages/1 or /pages/1.json
  def permalink
    @page = Page.find_by(permalink: params[:permalink])
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find_by(permalink: params[:id])
  end

  # POST /pages or /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to page_url(@page), notice: "Page was successfully created." }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end



  # PATCH/PUT /pages/1 or /pages/1.json
  def update
    respond_to do |format|
      if @page
        if @page.update(page_params)
          format.html { redirect_to page_url(@page), notice: 'Page was successfully updated.' }
          format.json { render :show, status: :ok, location: @page }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { error: 'Page not found' }, status: :not_found }
      end
    end
  end


  # DELETE /pages/1 or /pages/1.json
  def destroy
    @page.destroy!

    respond_to do |format|
      format.html { redirect_to pages_url, notice: "Page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
      #@page = Page.find_by(permalink: params[:permalink])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:title, :content, :permalink)
    end
end
