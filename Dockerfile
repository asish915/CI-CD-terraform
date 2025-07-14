# STAGE 1: Build app
FROM node:20-alpine AS build
WORKDIR /app

# Copy only package files to install dependencies first
COPY package*.json ./
RUN npm install

# Then copy all source files
COPY . ./
RUN npm run build

# STAGE 2: Serve with nginx
FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html
