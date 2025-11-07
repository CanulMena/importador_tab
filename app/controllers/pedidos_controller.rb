require 'csv'

class PedidosController < ApplicationController
  def index # Metodo para mostrar el total de ingresos
    @total_ingresos = Pedido.sum("precio_por_pieza * numero_de_piezas")
  end

  def import # Metodo para importar el archivo CSV
    if params[:file].nil? # 1. Validación para verificar si se ha subido un archivo
      redirect_to root_path, alert: "Por favor selecciona un archivo para subir."
      return
    end

  # Borra todos los registros existentes en la tabla 'pedidos'
  # Esto asegura que solo los datos del nuevo archivo permanezcan.
  Pedido.destroy_all
  # --------------------------------

    file = params[:file] # Obtenemos el archivo subido de manera temporal

    # 2. Validación de Extensión del Archivo (CSV o TXT)
    allowed_extensions = ['.csv', '.txt']
    uploaded_extension = File.extname(file.original_filename).downcase

    unless allowed_extensions.include?(uploaded_extension)
      redirect_to root_path, alert: "Formato de archivo no válido. Sube un archivo .csv o .txt (Subiste: #{uploaded_extension})."
      return
    end

    # Bloque de Manejo de Errores: Captura problemas de formato o de datos
    begin
      # 3. Procesamiento seguro del CSV
      # Importante: col_sep: "," es más seguro para archivos .csv estándar
      CSV.foreach(file.path, col_sep: ",", headers: true) do |row|
        Pedido.create!(
          cliente: row[0],
          descripcion_producto: row[1],
          precio_por_pieza: row[2],
          numero_de_piezas: row[3],
          direccion_vendedor: row[4],
          nombre_vendedor: row[5]
        )
      end

    # Capturamos errores específicos del formato CSV (ej. Illegal quoting)
    rescue CSV::MalformedCSVError => e
      # Si la importación falla debido a un formato incorrecto
      Rails.logger.error "CSV Import Error: #{e.message}"
      redirect_to root_path, alert: "El archivo subido está mal formado. Revisa el formato CSV o TSV. (Error: #{e.message.truncate(60)})"
      return

    # Capturamos cualquier otro error, como si un campo numérico tiene texto
    rescue ActiveRecord::StatementInvalid, ActiveRecord::RecordInvalid => e
      # Si hay errores en los datos (por ejemplo, precio es texto)
      Rails.logger.error "ActiveRecord Error: #{e.message}"
      redirect_to root_path, alert: "Error en los datos. Asegúrate de que los precios y cantidades sean números. (Error: #{e.message.truncate(60)})"
      return
    end

    # 4. Éxito
    redirect_to root_path, notice: "Archivo importado correctamente."
  end
end