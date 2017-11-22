FROM ubuntu
RUN apt-get update && apt-get install nodejs -y && apt-get install nodejs-legacy -y && apt-get install npm -y
RUN echo "Git Clone Repository"
COPY . /tmp/
RUN cd /tmp/node-js-sample/
RUN npm install && npm start &
EXPOSE 5000
