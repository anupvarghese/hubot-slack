FROM node:0.10.38

RUN apt-get update -qq && apt-get install -y \
      git \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

MAINTAINER  Anoop Varghese anoop@metaboard.io

WORKDIR /root
RUN npm install -g yo generator-hubot

RUN useradd -ms /bin/bash jarvis
ENV HOME /home/jarvis
# variables needed by hubot scripts
# ADD env-vars.sh /home/jarvis/.profile
RUN chown jarvis /home/jarvis/.profile

USER jarvis
WORDIR /home/jarvis
RUN echo n | yo hubot --defaults
RUN npm install hubot-slack hubot-scripts githubot --save

# enable plugins
RUN echo [ \'github-merge.coffee\' ] > hubot-scripts.json

CMD ["/home/jarvis/bin/hubot", "--name", "jarvis"]

EXPOSE 3000
