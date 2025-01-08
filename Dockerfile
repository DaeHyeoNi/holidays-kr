FROM python:3.11-slim

WORKDIR /app

# Install pipenv
RUN pip install --no-cache-dir pipenv

# Copy Pipfile and Pipfile.lock
COPY Pipfile* .

# Install dependencies using pipenv
RUN pipenv install --deploy --system

# Copy the rest of the application
COPY . .

CMD ["python", "main.py"]
