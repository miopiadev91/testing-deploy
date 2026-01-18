# Etapa 1: Build Angular
FROM node:20-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build --configuration=production

# Etapa 2: Nginx
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist/testing-deploy/browser /usr/share/nginx/html
EXPOSE 80
