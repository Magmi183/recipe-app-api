FROM python:3.7-alpine

# set an evironment variable PYTHONUNBUFFERED to 1
ENV PYTHONUNBUFFERED=1 

# copy our file on the docker image
COPY ./requirements.txt /requirements.txt

RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev

# after moving it to the image, install it
RUN pip install -r /requirements.txt 

# delete temp req
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# create user with not root access
RUN adduser -D user 
# activate the user
USER user 
