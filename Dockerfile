# set the base image to build from 
FROM node:alpine as build

# set the working directory
WORKDIR /app

# copy package files
COPY package.json ./
COPY package-lock.json ./

# install dependencies
RUN npm install

# copy everything to /app directory
COPY ./ ./

# build react app
RUN npm run build

# servce app using nginx
FROM nginx:alpine

# copy build manifest
COPY --from=build app/build/ /usr/share/nginx/html

EXPOSE 80

# Start nginx and run the app
CMD ["nginx", "-g", "daemon off;"]