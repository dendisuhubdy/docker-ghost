# Pull base image.
FROM dockerfile/nodejs
MAINTAINER Javi Velasco <javier.velasco86@gmail.com>

# Install Ghost
RUN mkdir -p /ghost

RUN cd /ghost && wget https://ghost.org/zip/ghost-0.5.0.zip -O ghost.zip
RUN cd /ghost && unzip ghost.zip && rm -f ghost.zip
RUN cd /ghost && npm install --production
RUN sed 's/127.0.0.1/0.0.0.0/' /ghost/config.example.js > /ghost/config.js

# Mount volumes.
VOLUME /ghost-override

# Define working directory.
WORKDIR /ghost

# Add files.
ADD start.sh /ghost-start

# Expose ports.
EXPOSE 2368

# Define an entry point.
ENV NODE_ENV production
CMD ["bash", "/ghost-start"]
