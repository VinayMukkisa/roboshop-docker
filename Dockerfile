FROM mongo:7.0
#Any scripts placed in this folder are automatically executed when the container starts for the first time
COPY *.js /docker-entrypoint-initdb.d 