# Homebrew installation script URL
HOMEBREW_INSTALL_URL = https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

# Check if Homebrew is already installed
check_homebrew:
	@command -v brew >/dev/null 2>&1 && { \
		echo "Homebrew is already installed."; \
		exit 0; \
	}

# Install Homebrew
install_homebrew: check_homebrew
	@echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL $(HOMEBREW_INSTALL_URL))"

# Add Homebrew to current shell environment
add_to_shell:
	@echo "Adding Homebrew to your current shell environment..."
	@eval "$(/opt/homebrew/bin/brew shellenv)" && \
	echo "Homebrew has been added to your current session."

# Install Brewfile
install_brewfile:
	@echo "Installing Brewfile..."
	@brew bundle --file=Brewfile

# Run all steps
all: install_homebrew add_to_shell install_brewfile
	@echo "Homebrew installation complete."
	@stow .

.PHONY: all check_homebrew install_homebrew add_to_shell install_brewfile
