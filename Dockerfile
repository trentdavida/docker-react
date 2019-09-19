FROM node:alpine

ENV PORT 3000
ENV HTTPS false
ENV CHOKIDAR_USEPOLLING true

RUN npm i -g create-react-app @material-ui/core \
    && mkdir -p /var/www && chmod 777 /var/www \
    && npx create-react-app /var/www/app \
    && sed -i 's/.*<title>.*/    <link rel=\"stylesheet\" href=\"https\:\/\/fonts\.googleapis\.com\/css\?family=Roboto\:300\,400\,500\" \/>\n&/' /var/www/app/public/index.html \
    && echo -e '#!/bin/ash\n\nif [ ! -d "node_modules" ]; then npm install; fi\n\n' > /bin/entrypoint \
    && echo -e 'if [ -z "$@" ]; then\n  npm start\nelse\n  exec "$@"\nfi' >> /bin/entrypoint \
    && chmod a+x /bin/entrypoint \
    && cp -a /var/www/app/ /tmp/app
    # Copies default generated App to /tmp/app so you can use
    #     docker cp to populate local volume mount if starting from scratch

WORKDIR /var/www/app

ENTRYPOINT [ "entrypoint" ]

VOLUME [ "/var/www/app" ]
EXPOSE 3000