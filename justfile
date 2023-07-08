# set shell for windows
set windows-shell:=['pwsh','-c']
# set shell for linux
set shell:=['bash','-c']

# set runner podman or docker
RUNNER:="podman" 
# RUNNER:="docker" 

# registry name
REGISTRY:="ghcr.io"
# REGISTRY:="docker.io"

# registry username
USER_NAME:="calhounchen"

# image name
IMAGE_NAME:="milkv-duo"

# image version
TAG_NAME:="latest"

# container name
CONTAINER_NAME:="duo"

# show help info
help:clear
	just -l

alias b:=build
# build image from Dockerfile
build-image:clear
	{{RUNNER}} build -t {{IMAGE_NAME}} -f Dockerfile

alias pull:=pull-image
# pull image from registry [default: latest]
pull-image:clear
	{{RUNNER}} pull {{REGISTRY}}/{{USER_NAME}}/{{IMAGE_NAME}}:{{TAG_NAME}}

alias v:=version
# show {{RUNNER}} version
version:clear
	{{RUNNER}} --version
alias r:=run

# run the image just built
run:clear
	{{RUNNER}} run --privileged --name {{CONTAINER_NAME}} -it {{IMAGE_NAME}}

alias copy:=copy-image
# copy target file to local disk
copy-image:clear
	{{RUNNER}} cp duo:/root/duo-buildroot-sdk/install/soc_cv1800b_milkv_duo_sd/milkv-duo.img  .

# clear console print
clear:clear
	@clear
