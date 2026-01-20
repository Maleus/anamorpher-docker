FROM python:3.11-slim

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends libgl1 libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir uv

COPY pyproject.toml uv.lock README.md /app/

ENV UV_PROJECT_ENVIRONMENT=/app/.venv
RUN uv sync --frozen --no-dev

COPY . /app

ENV ANAMORPHER_DEBUG=0
ENV PYTHONUNBUFFERED=1

EXPOSE 5000

CMD ["uv", "run", "python", "backend/app.py"]
