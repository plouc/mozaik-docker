FROM node:0.12.7-slim

ADD https://github.com/plouc/mozaik-demo/archive/master.tar.gz /

RUN tar -zxf master.tar.gz

WORKDIR /mozaik-demo-master

# Install nodejs dependencies with dev dependencies
# build assets, then rm and re-install without dev dependencies
RUN npm install \
  && npm install -g gulp \
  && gulp build \
  && rm -rf node_modules \
  && npm install --no-optional --production \
  && npm remove -g gulp

EXPOSE 5000

CMD ["node", "app.js"]
