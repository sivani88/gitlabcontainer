terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

resource "docker_volume" "gitlab_data" {
  name = "gitlab-data"
}

resource "docker_container" "gitlab" {
  image = "gitlab/gitlab-ce:latest"
  name  = "gitlab"
  ports {
    internal = 80
    external = 9001 # Port externe pour GitLab
  }
  volumes {
    container_path = "/etc/gitlab"
    volume_name    = docker_volume.gitlab_data.name
    read_only      = false
  }
  volumes {
    container_path = "/var/opt/gitlab"
    volume_name    = docker_volume.gitlab_data.name
    read_only      = false
  }
}
