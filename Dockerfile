FROM node:16.15.0
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
EXPOSE 8080
CMD [ "node", "server.js" ]
