set windows-shell:=['pwsh','-c']

# set runner podman or docker
RUNNER:="podman"

# set image name to build
IMAGE_NAME:="maskedzhang/milkv-duo"

# show help info
help:
	just -l

# build image from Dockerfile
build-image:
	{{RUNNER}} build -t {{IMAGE_NAME}} -f Dockerfile

# pull image from docker.io [default: latest]
pull-image:
  {{RUNNER}} pull docker.io/maskedzhang/milkv-duo

# show {{RUNNER}} version
version:
  {{RUNNER}} --version
# run the image just built
run:
	{{RUNNER}} run --privileged --name duo -it {{IMAGE_NAME}}
