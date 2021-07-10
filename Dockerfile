FROM python:3.7-alpine
MAINTAINER Savio Bajpai

# This is recommended when running Python in a docker contianer, indicating docker to run Python in unbuffered mode.
# The reason for this is, it does not allow Python to buffer the outputs, it just prints them directly.
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D dev_user
USER dev_user