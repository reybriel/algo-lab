.PHONY: setup

setup:
	@brew tap tuist/tuist
	@brew install --formula tuist

project:
	@tuist generate --no-open
	@rm -rf algo-lab.xcworkspace
	@open algo-lab.xcodeproj