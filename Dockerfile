# /app /usr /lib
# FROM --platform=linux/amd64 node:19.2-alpine3.16
# FROM --platform=$BUILDPLATFORM node:19.2-alpine3.16


## Dependencias de Desarrollo ##
FROM node:19.2-alpine3.16 as deps
WORKDIR /app
# Destino /app
COPY package.json ./
RUN npm install


## Tests y Build ##
FROM node:19.2-alpine3.16 as builder
WORKDIR /app
COPY  --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run test


## Dependencias de Producción ##
FROM node:19.2-alpine3.16 as prod-deps
WORKDIR /app
COPY package.json ./
RUN npm install --prod


## Ejecutar la App ##
FROM node:19.2-alpine3.16 as runner
WORKDIR /app
COPY  --from=deps /app/node_modules ./node_modules
COPY app.js ./
COPY tasks/ ./tasks
# Comando que se ejecuta cuando se hace el run de la imagen
CMD [ "node", "app.js" ]


# Eliminar archivos y directorios no necesarios en PRODUCCION
# RUN rm -rf tests && rm -rf node_modules