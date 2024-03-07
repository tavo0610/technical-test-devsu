FROM python:3.9

ENV DATABASE_NAME='db.sqlite3'

WORKDIR /app

COPY . /app

RUN pip install --progress-bar off -r requirements.txt

RUN python manage.py makemigrations
RUN python manage.py migrate

EXPOSE 8000

HEALTHCHECK --interval=5s --timeout=3s \
  CMD curl -f http://localhost:8000/api/ || exit 1

ENTRYPOINT ["python", "manage.py"]

CMD ["runserver", "0.0.0.0:8000"]