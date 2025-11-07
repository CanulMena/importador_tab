require 'csv'

class PedidosController < ApplicationController
  def index # Metodo para mostrar el total de ingresos
    @total_ingresos = Pedido.sum("precio_por_pieza * numero_de_piezas")
  end

  def import # Metodo para importar el archivo CSV
    if params[:file].nil? # Validacion para verificar si se ha subido un archivo
      redirect_to root_path, alert: "Por favor selecciona un archivo para subir."
      return
    end

    file = params[:file] #Procedemos a obtener el archivo subido - el servidor sube el archivo de manera temporal

    # validar que las extensiones sean .csv o .txt
    # unless ['.csv', '.txt'].include?(File.extname(file.original_filename).downcase)
    #   redirect_to root_path, alert: "Formato de archivo no válido. Por favor sube un archivo .csv o .txt."
    #   return
    # end

    CSV.foreach(file.path, col_sep: "\,", headers: true) do |row| # Iteramos cada fila del archivo CSV - menos la fila inicial (headers: true)
      # row["Mario", "Banco", "880", "1", "Merida, Yuc", "Montse"]
      Pedido.create!(
        cliente: row[0], # Tomamos el valor 1 de la fila
        descripcion_producto: row[1], # Tomamos el valor 2 de la fila
        precio_por_pieza: row[2], # Tomamos el valor 3 de la fila
        numero_de_piezas: row[3], # Tomamos el valor 4 de la fila
        direccion_vendedor: row[4], # Tomamos el valor 5 de la fila
        nombre_vendedor: row[5] # Tomamos el valor 6 de la fila
      )
    end

    redirect_to root_path, notice: "Archivo importado correctamente."
  end
end # Esto me indica el final de la clase PedidosController -> corchetes tradicionales...
