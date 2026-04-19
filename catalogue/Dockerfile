FROM node:20
WORKDIR /opt/server
copy package.json .
copy *.js .
RUN npm install
ENV MONGO="true" \
    MONGO_URL="mongodb://mongodb:27017/catalogue"
CMD ["node", "server.js"]