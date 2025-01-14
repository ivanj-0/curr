#!/bin/bash

# Name of the Docker image and container
IMAGE_NAME="anygpt_final_image"
CONTAINER_NAME="anygpt_final"

# Function to check if a Docker image exists
image_exists() {
    docker images -q "$IMAGE_NAME" > /dev/null 2>&1
}

# Function to check if a Docker container exists
container_exists() {
    docker ps -a --format '{{.Names}}' | grep -Eq "^${CONTAINER_NAME}\$"
}

# Function to check if a Docker container is running
container_running() {
    docker ps --format '{{.Names}}' | grep -Eq "^${CONTAINER_NAME}\$"
}

# Build the Docker image if it doesn't exist
if ! image_exists; then
    echo "Building Docker image..."
    docker build -t "$IMAGE_NAME" .
else
    echo "Docker image already exists."
fi

# Create and start the container if it doesn't exist
if ! container_exists; then
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
docker exec -it "$CONTAINER_NAME" /bin/bash -c "chmod +x setup.sh && setup.sh"