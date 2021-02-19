FROM python:3.7-alpine

# set an evironment variable PYTHONUNBUFFERED to 1
ENV PYTHONUNBUFFERED=1 

# copy our file on the docker image
COPY ./requirements.txt /requirements.txt

# after moving it to the image, install it
RUN pip install -r /requirements.txt 

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# create user with not root access
RUN adduser -D user 
# activate the user
USER user 
