FROM python:3.9
LABEL maintainer="brylie@amble.fi"

ENV PYTHONUNBUFFERED 1
ENV DJANGO_ENV dev

# Install system packages required by Django.
RUN apt-get update --yes --quiet && apt-get install --yes --quiet --no-install-recommends \
    build-essential \
    libpq-dev \
    libjpeg62-turbo-dev \
    zlib1g-dev \
    libwebp-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

# We use gunicorn to serve the project
RUN pip install gunicorn

# Poetry is used to manage dependencies
RUN pip install poetry

WORKDIR /app/
COPY . /app

# Note: we don't want Poetry to create a virtual environment
# Instead, it should use a local directory (hence --local?)
RUN poetry config virtualenvs.create false --local
# Install Poetry dependencies
RUN poetry install --no-dev

# Collect static files.
#RUN python project/manage.py collectstatic --noinput --clear

RUN useradd companionship --uid 33777
RUN chown -R companionship /app

USER companionship

# Port used by this container to serve HTTP.
EXPOSE 8000

# Run the server
CMD set -xe; gunicorn --chdir project/ core.wsgi:application --bind 0.0.0.0:5000 --workers 3