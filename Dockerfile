FROM patricktslee/uat-anchk-org:v1

# Prerequisites
#RUN apt-get update && apt-get install -y unzip xz-utils git openssh-client curl bash vim && apt-get upgrade -y && rm -rf /var/cache/apt

# Create app directory
WORKDIR /usr/src/app
#RUN mkdir -p bin/www

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
#COPY nodejs/package*.json ./

#RUN npm install
# If you are building your code for production
#RUN npm ci --only=production
#RUN npm install cors

# Bundle app source
#COPY . .

# Enable web capabilities
#RUN flutter config --enable-web
#RUN flutter upgrade
#RUN flutter pub global activate webdev
#WORKDIR /usr/src/app/src
#RUN flutter pub get
#RUN flutter build web --release

#WORKDIR /usr/src/app
#RUN cp -r src/build/web/. public-flutter
RUN npm cache clear --force
RUN npm install -g npm 
COPY build/web/. public-flutter

EXPOSE 8080
#CMD [ "node", "server.js" ]
CMD ["npm", "start"]