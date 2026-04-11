# container is machine 
# begin from the based image node or laravel
# in COPY . refre to the container 
FROM node:24

WORKDIR /app

COPY package*.json .

ARG NODE_ENV=production
ENV NODE_ENV=$NODE_ENV

RUN if [ "$NODE_ENV" = "production" ]; then npm ci --omit=dev; else npm ci; fi

COPY . .

EXPOSE 4000

CMD ["node", "src/index.js"]
# on running dockerfile it extracts docker image
# docker image can make more than one docker  container 
# each image is formed of layers 


# do i need to copy all files ? 
# answer

# docker exec -it (name of the container ) (the command i want to run )
# it refer to interactive terminal 

# ls command to list all files in my app 
# copy all files isnot correct for example node modules and package.lock.file and docker file 


# command to build docker image : docker build -t express-node-app . 



# List images:  
# docker images or docker image ls





# Pull image from Docker Hub:  
# docker pull <image_name>





# Build image from Dockerfile:  
# docker build -t <image_name> .
# -t → tag the image with a name
# --no-cache → build without using cached layers
# example: docker build -t express-node-app .


# Remove image:  
# docker rmi <image_name>



# Running Containers
# Create & run container:  
# docker run <image_name>
# --name <container_name> → assign a custom name
# -d → run in detached mode (background)
# -p <host_port>:<container_port> → map container ports to host
# -it → interactive terminal (useful for debugging)










# List running containers:  
# docker ps or docker container ls
# List all containers (including stopped):  
# docker ps -a
# Stop container:  
# docker stop <container_id>
# Start container:  
# docker start <container_id>
# Remove container:  
# docker rm <container_id>





# Execute command in running container:  
# docker exec -it <container_name> <command>
# Example: docker exec -it myapp bash → open shell inside container
# Attach to container:  
# docker attach <container_id>



# Remove unused containers/images/networks:  
# docker system prune
# Remove stopped containers only:  
# docker container prune
# Remove dangling images:  
# docker image prune



# Hot reload is a development feature that lets you 
# instantly see code changes in your running application without restarting it, making iteration faster and smoother.




# list logs docker logs express-node-app-container2




# One-Way Binding (Read-Only Mount)
# The container can read files from the host but cannot write back to it.
# docker run -v /host/path:/container/path:ro my-image








# Two-Way Binding (Read-Write Mount) — Default
# Changes on either side (host or container) are immediately reflected on the other.
# docker run -v /host/path:/container/path my-image



# Docker Volume
# A volume is a way to persist and share data between a Docker container and the host machine


# :ro (Read-Only) in Docker Volumes
# ro stands for read-only. It restricts the container from writing or modifying anything in that mounted volume.



# What is the "Mounted Volume"?
# When you mount a volume, it exists on the local machine (host) — the container just gets access to it.




# docker run -p 4000:4000 -v D:\docker-app\node-js-app:/app -v /app/node_modules express-node-app



# Bind Mount vs Anonymous Volume
# Bind Mount
# You specify both host path and container path.
# -v D:\docker-app\node-js-app:     /app
#  HOST PATH                     CONTAINER PATH





# Anonymous Volume
# You specify only the container path — no host path.
# -v /app/node_modules
# #  CONTAINER PATH ONLY



# Basic Level
# Q1: What is Docker Compose?

# A tool that lets you define and run multi-container Docker applications using a single docker-compose.yml file instead of multiple docker run commands.


# Q2: What is the default filename for Docker Compose?

# docker-compose.yml


# Q3: What command starts all services in Docker Compose?
# docker-compose up          # normal
# docker-compose up -d       # detached (background)
# docker-compose up --build  # rebuild images first

# Q4: What command stops all services?
# docker-compose down          # stop & remove containers
# docker-compose down -v       # also remove volumes
# docker-compose stop          # just stop, don't remove

# Q5: What are the main sections in docker-compose.yml?
# yamlversion: "3"        # compose version
# services:           # define containers
# networks:           # define networks
# volumes:            # define volumes



# Intermediate Level
# Q6: What is the difference between up and start?
# CommandMeaningdocker-compose upCreates + starts containersdocker-compose startStarts already created containers

# Q7: How do you scale a service in Docker Compose?
# docker-compose up --scale web=3
# # runs 3 instances of the web service

# Q8: What is depends_on in Docker Compose?
# yamlservices:
#   app:
#     depends_on:
#       - db        # app starts AFTER db starts
#   db:
#     image: postgres

# Controls startup order between services.


# Q9: How do you pass environment variables?
# yamlservices:
#   app:
#     environment:
#       - NODE_ENV=production
#       - PORT=4000
#     # OR from a file
#     env_file:
#       - .env

# Q10: How do you define volumes in Docker Compose?
# yamlservices:
#   app:
#     volumes:
#       - mydata:/app/data          # named volume
#       - ./src:/app/src            # bind mount
#       - /app/node_modules         # anonymous volume

# volumes:
#   mydata:                         # declare named volume

# Advanced Level
# Q11: Difference between docker-compose up --build vs docker build?
# --builddocker buildScopeBuilds + runs all servicesBuilds one image onlyUse caseRebuild & restart everythingJust rebuild image

# Q12: What is the difference between networks in Docker Compose vs default?

# By default, Compose creates a single network for all services — they can talk to each other by service name.

# yaml# app can reach db just by using "db" as hostname
# services:
#   app:
#     image: express-app
#   db:
#     image: postgres
# # app connects to db via:  postgres://db:5432

# Q13: How is Docker Compose different from docker run?
# docker runDocker ComposeContainersOne at a timeMultiple at onceConfigCommand line flagsyml fileNetworkingManualAutomaticReusability❌ Hard✅ Easy

# Q14: What does docker-compose down -v do?

# Stops containers, removes them, AND deletes all volumes — full cleanup including data.


# docker compose up -d	Starts all services in detached mode (runs in background).
# docker compose logs -f	Shows and follows logs from all services in real time.
# docker compose rm	Removes stopped service containers.
# docker compose down -v	Stops containers and removes networks and volumes.
# docker compose start	Starts existing containers without recreating them.
# docker compose stop	Stops running containers without removing them.
# docker compose restart	Restarts containers.
# docker compose build	Builds or rebuilds images defined in the Compose file.
# docker compose exec	Runs a command inside a running container (e.g., bash).
# docker compose down	Stops and removes containers, networks, but keeps volumes unless -v is added.
# docker compose ps	Lists running containers managed by Compose.
# docker compose logs	Displays logs from all services (without following).