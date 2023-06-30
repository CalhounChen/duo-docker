set windows-shell:=['pwsh','-c']

# set runner podman or docker
RUNNER:="podman"

# dockerhub username
DOCKERHUB_USERNAME:="maskedzhang"
# image name
IMAGE_NAME:="milkv-duo"

# show help info
help:clear
	just -l

# build image from Dockerfile
build-image:
	{{RUNNER}} build -t {{IMAGE_NAME}} -f Dockerfile

# pull image from docker.io [default: latest]
pull-image:
	{{RUNNER}} pull docker.io/{{DOCKERHUB_USERNAME}}/{{IMAGE_NAME}}

# show {{RUNNER}} version
version:
	{{RUNNER}} --version
# run the image just built
run:
	{{RUNNER}} run --privileged --name duo -it {{IMAGE_NAME}}
cp-image:
	podman cp duo:/root/duo-buildroot-sdk/install/soc_cv1800b_milkv_duo_sd/milkv-duo.img  .
clear:
	@clear
