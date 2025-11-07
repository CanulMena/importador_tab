Rails.application.routes.draw do
  root "pedidos#index" # '/' ruta principal ejecuta la funcion index del controlador Pedidos
  post "import", to: "pedidos#import" # Ruta '/import' ejecuta la funcion import del controlador Pedidos
end
