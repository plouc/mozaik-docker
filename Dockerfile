FROM node:0.12.7-slim

RUN apt-get update \
  && apt-get install unzip

ADD https://github.com/plouc/mozaik-demo/archive/master.zip /

RUN unzip master.zip

WORKDIR /mozaik-demo-master

# Install nodejs dependencies with dev dependencies
# build assets, then rm and re-install without dev dependencies
RUN npm install \
  && npm install -g gulp \
  && gulp build \
  && rm -rf node_modules \
  && npm install --no-optional --production \
  && npm remove -g gulp \
  && apt-get remove --purge -y unzip

EXPOSE 5000

CMD ["node", "app.js"]
