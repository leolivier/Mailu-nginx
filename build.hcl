variable "DOCKER_ORG" {
  default = "mailu"
}
variable "DOCKER_PREFIX" {
  default = ""
}
variable "PINNED_MAILU_VERSION" {
  default = "local"
}
variable "MAILU_TAG" {
  default = "local"
}

# -----------------------------------------------------------------------------------------
group "default" {
  targets = [
    "front"
  ]
}

target "defaults" {
  platforms = [ "linux/amd64", "linux/arm64", "linux/arm/v7" ]
  dockerfile="Dockerfile"
}

# -----------------------------------------------------------------------------------------
function "tag" {
  params = [image_name]
  result = [ "${DOCKER_ORG}/${DOCKER_PREFIX}${image_name}:${PINNED_MAILU_VERSION}", 
             "${DOCKER_ORG}/${DOCKER_PREFIX}${image_name}:${MAILU_TAG}",
             "${DOCKER_ORG}/${DOCKER_PREFIX}${image_name}:latest" 
          ]
}

target "front" {
  inherits = ["defaults"]
  context="."
  tags = tag("nginx")
}
