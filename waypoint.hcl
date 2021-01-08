project = "GreeterGrpc"


app "web" {
  labels = {
    "service" = "GreeterService",
    "env" = "dev"
  }
  build {
    use "docker" {
      buildkit = true
    }
    registry {
      use "aws-ecr" {
        region = "ap-northeast-2"
        repository = "waypoint-k8s"
        tag = "latest"
      }
    }
  }

  # Deploy to Docker
  deploy {
    use "kubernetes" {
      replicas = 3
    }
  }
  release {
    use "kubernetes" {
      load_balancer = true
      port = 50051
    }
  }
}
