class CreatePedidos < ActiveRecord::Migration[8.1]
  def change
    create_table :pedidos do |t|
      t.string :cliente
      t.string :descripcion_producto
      t.decimal :precio_por_pieza
      t.integer :numero_de_piezas
      t.string :direccion_vendedor
      t.string :nombre_vendedor

      t.timestamps
    end
  end
end
