class UploadsController < ApplicationController
  def new
    @receita_total = flash[:receita_total]
  end

  def create
    if params[:upload].present? && params[:upload][:file].present?
      file = params[:upload][:file].tempfile
      receita_total = normalize_and_save_data(file)
      flash[:receita_total] = receita_total

      redirect_to new_upload_path, notice: "Arquivo enviado e normalizado."
    else
      flash.now[:alert] = "Selecione um arquivo para enviar"
      render :new
    end
  end

  private

  def normalize_and_save_data(file)
    receita_total = 0

    File.foreach(file, encoding: "UTF-8") do |line|
      fields = line.chomp.split("\t")
      data = {
        purchaser_name: fields[0],
        item_description: fields[1],
        item_price: fields[2].to_f,
        purchase_count: fields[3].to_i,
        merchant_address: fields[4],
        merchant_name: fields[5]
      }

      Dado.create(data)

      receita_total += data[:item_price] * data[:purchase_count]
    end
    receita_total
  end
end
