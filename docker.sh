#!/bin/bash

CONTAINER_NAME="anygpt_final"
IMAGE_NAME="myrepo/myimage:latest"  # Define your image name and tag here

# Function to check if a Docker container exists
container_exists() {
    docker ps -a --format '{{.Names}}' | grep -Eq "^${CONTAINER_NAME}\$"
}

# Function to check if a Docker container is running
container_running() {
    docker ps --format '{{.Names}}' | grep -Eq "^${CONTAINER_NAME}\$"
}

# Create and start the container if it doesn't exist
if ! container_exists; then
    echo "Building Docker image..."
    docker build -t "$IMAGE_NAME" .
    echo "Creating and starting the container..."
    docker run -d --name "$CONTAINER_NAME" "$IMAGE_NAME"
elif ! container_running; then
    echo "Starting the existing container..."
    docker start "$CONTAINER_NAME"
else
    echo "Container is already running."
fi

# Run setup.sh inside the container
echo "Running setup.sh inside the container..."
docker exec -d "$CONTAINER_NAME" /bin/bash -c "chmod +x setup.sh && ./setup.sh"
# Tail the logs to keep seeing what's happening
docker logs -f "$CONTAINER_NAME"