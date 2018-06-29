class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :destroy]

  # GET /attachments
  # GET /attachments.json
  def index
    @attachments = Attachment.all
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new
  end

  # POST /attachments
  # POST /attachments.json
  def create
    @attachment = Attachment.new(attachment_params)
    @attachment.name = @attachment.file.blob.checksum
    respond_to do |format|
      if @attachment.save
        convert_to_line
        format.html { redirect_to attachment_line_list_path(@attachment), notice: 'Attachment was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment.file.purge
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to lines_url, notice: 'Attachment was successfully destroyed.' }
    end
  end

  def line_list
    @attachment = Attachment.find(params[:attachment_id])
    @lines = Line.where(attachment: @attachment )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.fetch(:attachment).permit(:file)
    end

    def convert_to_uft8(string)
      string.encode("ASCII-8BIT").force_encoding("utf-8")
    end

    def convert_to_line
      file = @attachment.file.blob.download
      arr = file.split(/\n/)
      arr.shift
      arr.each do |l|
        line_arr = l.split(/\t/)
        line = Line.new(buyer: convert_to_uft8(line_arr[0]), description: convert_to_uft8(line_arr[1]), unit_price: line_arr[2].to_f, quantity: line_arr[3].to_i,
                        total: line_arr[2].to_f * line_arr[3].to_f, address: convert_to_uft8(line_arr[4]), supplier: convert_to_uft8(line_arr[5]), attachment: @attachment)
        line.save

      end
    end
end
