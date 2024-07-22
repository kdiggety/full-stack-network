# Set the required provider and versions
terraform {
  required_providers {
    # We recommend pinning to the specific version of the Docker Provider you're using
    # since new versions are released frequently
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

# Create a docker image resource
# -> docker pull nginx:latest
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

# Create a docker container resource
# -> same as 'docker run --name nginx -p8080:80 -d nginx:latest'
resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.nginx.image_id

  ports {
    external = 8080
    internal = 80
  }
}

resource "docker_image" "kafka_local" {
  name         = "bitnami/kafka"
  keep_locally = true
}

resource "docker_container" "kafka_local" {
  image = docker_image.kafka_local.name
  name  = "kafka_local"
  env = [
    "KAFKA_CFG_NODE_ID=0",
    "KAFKA_CFG_PROCESS_ROLES=controller,broker",
    "KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=0@kafka_local:9093",
    "KAFKA_CFG_LISTENERS=PLAINTEXT://:9092,CONTROLLER://:9093,EXTERNAL://:9094,EXTERNAL_SAME_HOST://:29092,EXTERNAL_DIFFERENT_HOST://:29093,INTERNAL://:9095",
    "KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://:9092,EXTERNAL://localhost:9094,INTERNAL://:9095,EXTERNAL_SAME_HOST://localhost:29092,EXTERNAL_DIFFERENT_HOST://192.168.1.238:29093",
    "KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=CONTROLLER:PLAINTEXT,EXTERNAL:PLAINTEXT,PLAINTEXT:PLAINTEXT,INTERNAL:PLAINTEXT,EXTERNAL_SAME_HOST:PLAINTEXT,EXTERNAL_DIFFERENT_HOST:PLAINTEXT",
    "KAFKA_CFG_CONTROLLER_LISTENER_NAMES=CONTROLLER",
    "KAFKA_CFG_INTER_BROKER_LISTENER_NAME=PLAINTEXT"
  ]

  ports {
    external = 9094
    internal = 9094
  }

  ports {
    external = 29093
    internal = 29093
  }

  volumes {
    volume_name = docker_volume.kafka_data.name
    container_path = "/bitnami"
  }

  remove_volumes = false

  #network_mode = "${docker_network.full-stack-network.name}"

  attach = false

  network_mode = "2a90babb2784d4ea2d369c9c5ee227a4cd17fbe1cce2d52175b89acbf0dcbfc0"

  networks_advanced {
    name         = docker_network.full-stack-network.name
    ipv4_address = ""
  }
}

# get the mongo docker image
resource "docker_image" "mongodb_local" {
  name         = "mongo"
  keep_locally = true
}

# start a container and expose the 27017 port
resource "docker_container" "mongodb_local" {
  image = docker_image.mongodb_local.image_id
  name  = "mongodb_local"
  ports {
    internal = 27017
    external = var.mongo_exposed_port
  }

  network_mode = "2a90babb2784d4ea2d369c9c5ee227a4cd17fbe1cce2d52175b89acbf0dcbfc0"

  networks_advanced {
    name         = docker_network.full-stack-network.name
    ipv4_address = ""
  }
}

# get the elasticsearch docker image
resource "docker_image" "elasticsearch_local" {
  name         = "elasticsearch"
  keep_locally = true
}

# start a container and expose the 27017 port
resource "docker_container" "elasticsearch_local" {
  image = docker_image.elasticsearch_local.image_id
  name  = "elasticsearch_local"
  ports {
    internal = 9200
    external = var.elasticsearch_exposed_port
  }

  network_mode = "2a90babb2784d4ea2d369c9c5ee227a4cd17fbe1cce2d52175b89acbf0dcbfc0"

  networks_advanced {
    name         = docker_network.full-stack-network.name
    ipv4_address = ""
  }
}

resource "docker_volume" "kafka_data" {
  name = "full-stack-network_kafka_data"

  labels {
    label = "com.docker.compose.project"
    value = "full-stack-network"
  }
  labels {
    label = "com.docker.compose.version"
    value = "2.24.6"
  }
  labels {
    label = "com.docker.compose.volume"
    value = "kafka_data"
  }
}

resource "docker_volume" "redis_data" {
  name = "full-stack-network_redis_data"

  labels {
    label = "com.docker.compose.project"
    value = "full-stack-network"
  }
  labels {
    label = "com.docker.compose.version"
    value = "2.24.6"
  }
  labels {
    label = "com.docker.compose.volume"
    value = "kafka_data"
  }
}

resource "docker_volume" "elasticsearch_data" {
  name = "full-stack-network_elasticsearch_data"

  labels {
    label = "com.docker.compose.project"
    value = "full-stack-network"
  }
  labels {
    label = "com.docker.compose.version"
    value = "2.24.6"
  }
  labels {
    label = "com.docker.compose.volume"
    value = "kafka_data"
  }
}

resource "docker_network" "full-stack-network" {
  name     = "full-stack-network"
  driver   = "bridge"
  internal = false
}
