FROM alpine:3.7
MAINTAINER Max Neunhoeffer <max@arangodb.com>

RUN apk update && apk add nodejs pwgen && npm install -g foxx-cli
COPY install.tar.gz /install.tar.gz
COPY setup.sh /setup.sh
RUN cd / && tar xzvf install.tar.gz && rm /install.tar.gz && /setup.sh

# The following is magic for unholy OpenShift security business.
# Containers in OpenShift by default run with a random UID but with GID 0,
# and we want that they can access the database and doc directories even
# without a volume mount:
RUN chgrp 0 /var/lib/arangodb3 /var/lib/arangodb3-apps && chmod 775 /var/lib/arangodb3 /var/lib/arangodb3-apps

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 8529
CMD [ "arangod" ]
