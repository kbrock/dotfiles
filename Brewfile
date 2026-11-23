# Personal machines opt into the extras:
#   HOMEBREW_FULL=1 brew bundle install  (brew hides env vars without the HOMEBREW_ prefix)

# Basic setup
brew "bash" # Modern bash shell
brew "bash-completion@2" # Bash completion scripts
# brew "coreutils" # GNU core utilities (better than BSD versions)
brew "vim" # Vi improved text editor
brew "cmake" # Cross-platform build system
brew "pkg-config" # Manage compile and link flags (may be installed from source, not via brew)
brew "curl" # Transfer data with URLs
brew "wget" # Internet file retriever
brew "jq" # JSON processor
brew "e2fsprogs" # ext2/3/4 filesystem tools (Linux disk images, SD cards)
brew "tree" # Display directory structure
brew "ripgrep" # Fast grep alternative (rg)
#brew "the_silver_searcher" # Code search tool (ag)
brew "iproute2mac" # Linux ip command for macOS network debugging
brew "mas" # Mac App Store command line interface
brew "duti" # Set default document and URL handlers (used by macos_apply.sh)
# brew "switchaudio-osx" # Switch macOS audio input/output device from CLI (used by bin/headphones)
brew "just" # Command runner
# brew "nginx" # Web server for local development
# cask "google-drive"

# Development setup - Fonts
cask "font-open-sans" # Humanist sans serif font
cask "font-jetbrains-mono" # The font: Zed buffer_font_family and code_font_family; choose it in Rex Settings > Terminal > Typography
cask "font-roboto" # Google's signature font
cask "font-mona-sans" # GitHub's variable sans-serif font
cask "font-roboto-mono" # Monospace variant of Roboto
# cask "font-monaspace-frozen" # Monaspace Neon (was Ghostty's statusline symbols; Rex bundles Nerd Font symbols)
cask "font-fira-code" # Monospace font with coding ligatures; no config selects it
cask "font-hack" # Monospace alternative; no config selects it
cask "font-source-code-pro" # Monospace alternative; no config selects it
cask "font-symbols-only-nerd-font" # Nerd Font icons (statusline STATUSLINE_ICONS=nerd); Rex bundles its own, other terminals may not

# Development setup - Editors and IDEs
# cask "sublime-text" # Text editor
cask "sublime-merge" # Git client from Sublime
cask "zed" # High-performance code editor
# cask "sf-symbols" # Apple SF Symbols browser and toolkit

# Development setup - Databases
if ENV["HOMEBREW_FULL"]
  brew "postgresql@18", restart_service: true, link: true # PostgreSQL database
  brew "mysql" # MySQL relational database
  brew "mysql-client" # MySQL client
  brew "redis", restart_service: true # In-memory data store
end
brew "sqlite3" # SQLite database (may be installed from source, not via brew)

# Development setup - Language version managers and runtimes
# brew "chruby" # Ruby version manager (replaced by asdf; kbrock/chruby fork in ~/src/gems)
# brew "ruby-build" # Not needed: asdf-ruby downloads its own pinned ruby-build
brew "yamllint" # YAML linter
if ENV["HOMEBREW_FULL"]
  brew "fnm" # Fast Node.js version manager (instead of nvm)
  # brew "node" # Node.js JavaScript runtime
  # brew "uv" # Python package manager (vs env)
  brew "bun" # JavaScript runtime & package manager
  brew "go" # Go programming language
  brew "rustup" # Rust toolchain installer (PATH set in bashrc.d/rust.sh)
  brew "yarn" # JavaScript package manager
end
# brew "crystal" # Crystal programming language

# Development setup - Cloud and infrastructure
brew "awscli" # AWS command line interface
tap "hashicorp/tap"
brew "hashicorp/tap/packer" # Build machine images
brew "xorriso" # Builds ISO images (packer cd_files / cloud-init seed)
if ENV["HOMEBREW_FULL"]
  brew "hashicorp/tap/terraform" # Infrastructure as code
  cask "dynamodb-local" # Local DynamoDB for development
end

# Virtualization and containers
brew "lima" # Linux virtual machines
brew "qemu" # Generic machine emulator and virtualizer
brew "docker" # Docker CLI
brew "docker-compose" # Multi-container Docker
brew "docker-buildx" # Docker Buildx plugin
brew "container" # Apple native container/Linux-VM runtime
if ENV["HOMEBREW_FULL"]
  # tap "suruseas/opossum"
  # brew "suruseas/opossum/opossum" # Docker Compose-like orchestrator for Apple's container runtime
  brew "kubernetes-cli" # Kubernetes command-line tool (kubectl)
  # brew "helm" # Kubernetes package manager
end

# Development setup - GitHub and CI
brew "git" # Version control system
brew "gh" # GitHub CLI
# brew "git-filter-repo" # Rewrite Git history
# brew "act" # Run GitHub Actions locally
# brew "wrkflw" # Validate and execute GitHub Actions workflows locally

# Development setup - AI and ML
if ENV["HOMEBREW_FULL"]
  brew "llama.cpp" # Local LLM inference (llama-server)
  brew "whisper.cpp" # Local speech-to-text (whisper-server; see whisper/)
  brew "rtk" # CLI proxy to minimize LLM token consumption
end
cask "claude" # Claude desktop app
cask "claude-code@latest" # Claude Code AI coding assistant
# cask "codex" # OpenAI Codex CLI/app
# cask "copilot-cli" # GitHub Copilot CLI
# cask "draw-things" # Local Stable Diffusion image generation

# Media and document conversion
# brew "poppler" # PDF tools (pdftotext, pdfimages, etc.)
brew "graphviz" # Graph visualization software
if ENV["HOMEBREW_FULL"]
  brew "pandoc" # Document converter
  brew "svg2png" # SVG to PNG converter
  brew "svgo" # SVG optimizer
  brew "weasyprint" # HTML/CSS to PDF
  cask "inkscape" # Vector graphics editor
  brew "mermaid-cli" # Mermaid cli (mmdc)
end
cask "shottr" # Screenshot annotation tool
# cask "sonic-pi" # ruby music generation

# Media ripping, recovery, and transcoding
# brew "handbrake" # Video transcoder CLI
# cask "handbrake-app" # Video transcoder GUI
# brew "mkvtoolnix" # MKV manipulation (chapter/cover injection)
# cask "vlc" # Media player (MKV, etc.)
# brew "ffmpeg" # Audio/video processing tools
# brew "dvdbackup" # DVD backup tool
# brew "ddrescue" # Data recovery tool
# cask "makemkv" # MKV ripping tool
# cask "balenaetcher" # Create bootable USB drives

# Productivity apps
cask "google-chrome" # Google Chrome web browser
cask "brave-browser" # Brave web browser
# cask "opera" # Opera web browser
cask "1password" # Password manager
cask "alfred" # Application launcher and productivity tool
cask "keepingyouawake" # Keep-awake menu bar app (brew alternative to App Store Amphetamine)
tap "asmvik/formulae"
brew "asmvik/formulae/skhd" # Hotkey daemon: global keys and leader modes from a text file
# cask "hammerspoon" # Lua automation (hotkeys, window moves); alternative to skhd
tap "typewhisper/tap"
cask "typewhisper" # Speech-to-text and AI text processing
# cask "obsidian" # Note-taking and knowledge base
cask "daisydisk" if ENV["HOMEBREW_FULL"] # Disk space analyzer
# cask "sloth" # Show open files and ports per process (GUI for lsof)
# TurboTax 2025: manual install (Homebrew only carries turbotax-2024)

# USB Devices
cask "betterdisplay" # Display management utility
cask "raspberry-pi-imager" # Write OS images to SD cards and USB drives
cask "quicklook-video" # QuickLook thumbnails, previews and metadata for video files
cask "terminal-browser" # Terminal-based web browser
cask "logitune" # Logitech keyboard/camera firmware configuration tool
if ENV["HOMEBREW_FULL"]
  cask "betterzip" # Quicklook plugin for zip files
end

# Communication apps
# cask "discord" # Voice, video, and text chat
# cask "keybase" # Encrypted messaging and file sharing
cask "slack" # Team communication
cask "zoom" # Video conferencing
cask "steam" if ENV["HOMEBREW_FULL"] # Gaming platform
# cask "dayflow" # Screensaver (was "day-o")

# p: everything its bin/setup installs, in one spot (docker comes from the formula above)
brew "asdf" # Language version manager (Ruby and others)
# brew "mise" # asdf alternative; reads .tool-versions, but bin/setup expects asdf commands
brew "libyaml" # Ruby's psych extension needs it to build
brew "libpq" # psql and friends without a server (also used by ~/pgbin)
brew "aws-vault" # Store AWS credentials in keychain (also used by awsv alias)
brew "imagemagick" # Image processing tools
brew "ffmpeg@5" # Keg-only; pinned to match prod
brew "shared-mime-info" # MIME database for the marcel gem
brew "ollama" # Run large language models locally
