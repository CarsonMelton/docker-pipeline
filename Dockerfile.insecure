FROM python:latest
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
EXPOSE 8080
# runs as root by default (bad)
CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:8080", "app:app"]
