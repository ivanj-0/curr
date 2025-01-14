# Use the official Python 3.9 slim image as a base
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    git \
    curl \
    wget \
    bzip2 \
    && rm -rf /var/lib/apt/lists/*

# Install Conda (Miniconda)
RUN wget -qO- https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh > miniconda.sh && \
    bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh

# Add Conda to PATH
ENV PATH="/opt/conda/bin:$PATH"

# Verify Conda installation
RUN conda --version

# Install any other needed dependencies (optional)
# You can add dependencies to a `requirements.txt` file if needed
# RUN pip install --no-cache-dir -r requirements.txt

# Expose port 80 (optional, only needed if you're running a web app)
EXPOSE 80

# Start a shell by default (you can change this to your app if needed)
CMD ["/bin/bash"]