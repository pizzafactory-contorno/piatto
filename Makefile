all:
	find * -type d -exec ln -sf ../entrypoint.sh {} \;
