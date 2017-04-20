FROM node:7

ENV YARN_VERSION 0.23.2

RUN set -ex \
	&& for key in \
		6A010C5166006599AA17F08146C2130DFD2497F5 \
	; do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
		gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
		gpg --keyserver keyserver.pgp.com --recv-keys "$key" ; \
	done \
	&& curl -fSL -o yarn.js "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-$YARN_VERSION.js" \
	&& curl -fSL -o yarn.js.asc "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-$YARN_VERSION.js.asc" \
	&& gpg --batch --verify yarn.js.asc yarn.js \
	&& rm yarn.js.asc \
	&& mv yarn.js /usr/local/bin/yarn \
	&& chmod +x /usr/local/bin/yarn \
	# https://github.com/yarnpkg/yarn/issues/2266
	&& yarn global add node-gyp

WORKDIR /srv/image-resizer-instance

RUN yarn global add https://github.com/tripviss/image-resizer.git#v1.6.2 \
	&& image-resizer new \
	&& yarn install --production \
	&& yarn cache clean

EXPOSE 3001
CMD ["npm", "start"]
