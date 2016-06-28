FROM node:6
MAINTAINER Teoh Han Hui <teohhanhui@gmail.com>

WORKDIR /srv/image-resizer-instance

RUN npm install -g tripviss/image-resizer#v1.4.4 \
	&& image-resizer new \
	&& npm install --production \
	&& npm cache clean

EXPOSE 3001

CMD ["npm", "start"]
