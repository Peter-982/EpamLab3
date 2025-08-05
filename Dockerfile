FROM node:7.8.0
WORKDIR /opt
ADD . /opt
RUN npm install
ENV REACT_APP_PORT=3000
ENTRYPOINT npm run start