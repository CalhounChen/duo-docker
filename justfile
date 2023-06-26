set windows-shell:=['pwsh','-c']
IMAGE_NAME:="maskedzhang/milkv-duo"

# show help info
help:
	just -l
# build image from dockerfile
build-image:
	podman build -t {{IMAGE_NAME}} -f ./dockerfile
# pull ubuntu:latest image
pull:
	podman pull ubuntu
# run image buildt
run:
	podman run --name duo -it --privileged -w /root/ {{IMAGE_NAME}}
