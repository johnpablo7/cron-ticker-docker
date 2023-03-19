# /app /usr /lib
# FROM --platform=linux/amd64 node:19.2-alpine3.16
# FROM --platform=$BUILDPLATFORM node:19.2-alpine3.16
FROM node:19.2-alpine3.16 as deps

# cd app
WORKDIR /app

# Destino /app
COPY package.json ./

# Instalar las dependencias
RUN npm install


FROM node:19.2-alpine3.16 as builder

WORKDIR /app

COPY  --from=deps /app/node_modules ./node_modules

COPY . .

RUN npm run test


FROM node:19.2-alpine3.16 as runner

# Destino /app
# COPY app.js ./

# Destino /app
COPY . .

# Realizar testing
RUN npm run test

# Eliminar archivos y directorios no necesarios en PRODUCCION
RUN rm -rf tests && rm -rf node_modules

# Unicamente las dependencias de PRODUCCION
RUN npm install --prod

# Comando que se ejecuta cuando se hace el run de la imagen
CMD [ "node", "app.js" ]