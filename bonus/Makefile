

all:
	@cd scripts && ./setting-up-k3d.sh
	@cd scripts && ./build.sh

re: clean all

clean:
	@cd scripts && ./clean-k3d.sh
	@cd scripts && ./clean-docker.sh
launch:
	@cd scripts && ./launch-app.sh

check:
	@cd scripts && ./check-docker.sh
	@cd scripts && ./check-k3d.sh

