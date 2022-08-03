FROM node:18.7.0-alpine

WORKDIR /app
COPY src/package*.json ./
RUN npm install
COPY src/ .
EXPOSE 8080
CMD ["node", "server.js"]
