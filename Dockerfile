# Base Image
FROM python:3.6
# create and set working directory
RUN mkdir /app
WORKDIR /app

# Add current directory code to working directory
ADD . /app/

# set default environment variables
ENV PYTHONUNBUFFERED 1
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive 

# set project environment variables
# grab these via Python's os.environ
# these are 100% optional here
ENV PORT=8000

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        tzdata \
        python3-setuptools \
        python3-pip \
        python3-dev \
        python3-venv \
        gunicorn3 \
        git \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# install environment dependencies
#RUN python3 -m venv env
#RUN ls
#RUN source env/bin/activate
#RUN . env/bin/activate

#RUN pip3 install gunicorn
RUN pip3 install --upgrade pip 
RUN pip3 install poetry

# Install project dependencies
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev
#RUN pipenv install --skip-lock --system --dev

EXPOSE 8888
#CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "main:app"]
CMD gunicorn cfehome.wsgi:application --bind 0.0.0.0:$PORT
#CMD ["gunicorn", "cfehome.wsgi:application" , "-bind", "0.0.0.0:$PORT"]
#COPY entrypoint.sh wsgi.py ./
#CMD ["./entrypoint.sh"]
#RUN chmod +x startup.sh
#CMD ["./startup.sh"]
#ENTRYPOINT ["sh", "startup.sh"]
