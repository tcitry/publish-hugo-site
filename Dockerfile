FROM debian:stable-slim

LABEL "maintainer"="tcitry <tcitry@gmail.com>"
LABEL "repository"="https://github.com/tcitry/publish-hugo-site"
LABEL "homepage"="https://github.com/marketplace/actions/publish-hugo-site"

LABEL "com.github.actions.name"="Publish Hugo Site"
LABEL "com.github.actions.description"="Publish your hugo site to master or other gh-pages"
LABEL "com.github.actions.icon"="book-open"
LABEL "com.github.actions.color"="green"

COPY LICENSE README.md /

RUN apt-get -y update && \
    apt-get -y install git && \
    apt-get -y install hugo && \
    apt-get -y install curl && \
    apt-get clean

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]