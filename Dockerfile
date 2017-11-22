FROM ubuntu
RUN apt-get update && apt-get install nodejs -y && apt-get install nodejs-legacy -y && apt-get install npm -y
RUN echo "Git Clone Repository"
COPY /var/lib/jenkins/workspace/nodejs-pipeline/node-js-sample /tmp/
RUN cd /tmp/ && npm install && npm start &
EXPOSE 5000
