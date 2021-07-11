FROM python:3.7-alpine
MAINTAINER Savio Bajpai

# This is recommended when running Python in a docker contianer, indicating docker to run Python in unbuffered mode.
# The reason for this is, it does not allow Python to buffer the outputs, it just prints them directly.
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D dev_user
USER dev_user