FROM node:20-alpine AS build
WORKDIR /app

# Copy only the necessary files from vite-app/
COPY vite-app/package*.json ./

RUN npm install

# Copy the rest of the source code
COPY vite-app/ ./

RUN npm run build

FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html

