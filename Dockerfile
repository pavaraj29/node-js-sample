FROM ubuntu
RUN apt-get update 
RUN apt-get install nodejs* -y
RUN apt-get install npm -y
RUN echo "Git Clone Repository"
COPY /var/lib/jenkins/workspace/nodejs-pipeline/node-js-sample /tmp/
RUN cd /tmp/ && npm install && npm start &
EXPOSE 5000