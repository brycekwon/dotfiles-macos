BREW := /opt/homebrew/bin/brew
BREWFILE := ./Brewfile

.PHONY: all install_brew install_packages stow

all: install_brew install_packages stow

# Check if Homebrew is installed
install_brew:
	@echo "Checking if Homebrew is installed..."
	@if ! command -v $(BREW) >/dev/null 2>&1; then \
		echo "Homebrew not found. Installing..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	@echo "Sourcing Homebrew..."
	@eval "$$($(BREW) shellenv)"

# Install packages from Brewfile
install_packages:
	@echo "Installing packages from Brewfile..."
	@if [ -f $(BREWFILE) ]; then \
		$(BREW) bundle --file=$(BREWFILE); \
	else \
		echo "No Brewfile found."; \
	fi

# Run stow command
stow:
	@echo "Running stow command..."
	stow .
