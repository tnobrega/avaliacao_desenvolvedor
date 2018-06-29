class LinesController < ApplicationController
  before_action :set_line, only: [:edit, :update, :destroy]

  # GET /lines
  # GET /lines.json
  def index
    @lines = Line.all
  end

  # GET /lines/1/edit
  def edit
  end

  # PATCH/PUT /lines/1
  # PATCH/PUT /lines/1.json
  def update
    respond_to do |format|
      if @line.update(line_params)
        format.html { redirect_to attachment_line_list_path(@line.attachment), notice: 'Line was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /lines/1
  # DELETE /lines/1.json
  def destroy
    @line.destroy
    respond_to do |format|
      format.html { redirect_to attachment_line_list_path(@line.attachment), notice: 'Line was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line
      @line = Line.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_params
      params.require(:line).permit(:buyer, :description, :unit_price, :quantity, :total, :address, :supplier, :attchment_id)
      params["line"]["total"] = (params["line"]["unit_price"].to_f * params["line"]["quantity"].to_f).to_s
      params.require(:line).permit(:buyer, :description, :unit_price, :quantity, :total, :address, :supplier, :attchment_id)
    end
end
