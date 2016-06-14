FROM node:6
MAINTAINER Teoh Han Hui <teohhanhui@gmail.com>

WORKDIR /srv/image-resizer-instance

RUN npm install -g tripviss/image-resizer \
	&& image-resizer new \
	&& npm install --link --save tripviss/image-resizer \
	&& npm install \
	&& npm cache clean

EXPOSE 3001

CMD ["npm start"]
