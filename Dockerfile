FROM python:3.11-slim

# Install uv
RUN pip install uv

# Set workdir
WORKDIR /app

# Copy dependency files first (for caching)
COPY pyproject.toml uv.lock ./

# Install dependencies
RUN uv sync

# Copy rest of project
COPY . .

# Add venv to PATH
ENV PATH="/app/.venv/bin:$PATH"

CMD ["tail", "-f", "/dev/null"]