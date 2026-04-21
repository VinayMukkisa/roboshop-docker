
#using multi stage builds to reduce the size of the final image and also to follow best practices of using a base image for the final stage and running the application as a non-root user.
FROM node:20.19.5-alpine3.21 AS build
WORKDIR /opt/server
COPY package.json .
COPY *.js .
RUN npm install

#running the application as a non-root user for security reasons and also to follow best practices of using a base image for the final stage.
FROM node:20.19.5-alpine3.21
WORKDIR /opt/server
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
RUN chown -R roboshop:roboshop /opt/server
ENV MONGO="true" \
    MONGO_URL="mongodb://mongodb:27017/catalogue"
COPY --from=build --chown=roboshop:roboshop /opt/server /opt/server
USER roboshop
CMD ["node", "server.js"]




#commented out the old code to follow best practices usage of base image,mutli stage builds and run as non-root user in the dockerfile.

# FROM node:20
# WORKDIR /opt/server
# COPY package.json .
# COPY *.js .
# RUN npm install
# ENV MONGO="true" \
#     MONGO_URL="mongodb://mongodb:27017/catalogue"
# CMD ["node", "server.js"]