# Importador Tab - Code Challenge Rails

Esta aplicación permite importar archivos `.tab` o `.csv` con información de pedidos, almacenar los datos en una base de datos PostgreSQL (Neon) y calcular el total de ingresos.

La aplicación está construida en **Ruby on Rails** y es compatible con Linux y MacOS.

---

## Requisitos

- Ruby 3.4
- Rails 7.x
- PostgreSQL (usando Neon como base remota)
- Bundler (`gem install bundler`)

---

## Instalación

1. Clona el repositorio:

git clone <URL_DEL_REPOSITORIO>
cd importador_tab

2. Instala las dependencias:

bundle install

3. Configura las variables de entorno:

Copia el archivo de template .env.example a .env:

cp .env.example .env


Abre .env y agrega tu DATABASE_URL de Neon:

# Solo en esta ocación se esta dando un .enviroment ya que en producción esto no se debería de realizar.... Se entrega en caso de no querer un DATABASE_URL de neon o alguna BD postgres en producción.

DATABASE_URL=postgresql://neondb_owner:npg_riJ5uZ3KRqFA@ep-old-mud-ad43b6wj-pooler.c-2.us-east-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require

3. Crea la base de datos y aplica las migraciones en caso que tengas tu propia base de datos sino utiliza la anteriormente dada.

Uso

1. Levanta el servidor Rails:

bin/rails server


2. Abre tu navegador y ve a:

http://localhost:3000


Desde la página principal, sube tu archivo .tab o .csv.

La aplicación procesará el archivo y mostrará el total de ingresos calculado automáticamente.