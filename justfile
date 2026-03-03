alias b := build
alias r := run
alias c := clean

build:
	nixos-rebuild build-vm --flake .#vm
	@echo -e "\nYou can now run with 'just run', you will be autologged in"

run:
	./result/bin/run-nixos-vm

clean:
	rm ./nixos.qcow2
