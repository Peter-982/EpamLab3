FROM node:7.8.0
WORKDIR /opt
ADD . /opt
RUN npm install
ENV REACT_APP_PORT=3001
ENTRYPOINT npm run start