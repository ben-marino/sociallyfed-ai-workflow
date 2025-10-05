#!/bin/bash

###############################################################################
# SociallyFed AI Workflow - Setup Wizard
# 
# This script sets up the development environment for the SociallyFed AI 
# Workflow, including:
# - Finding Google Drive location
# - Creating necessary directory structure
# - Configuring paths
# - Making scripts executable
#
# Usage: ./scripts/setup.sh
###############################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Config file location
CONFIG_DIR="$HOME/.config/sociallyfed"
CONFIG_FILE="$CONFIG_DIR/config.sh"

###############################################################################
# Helper Functions
###############################################################################

print_header() {
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                                                          ║${NC}"
    echo -e "${BLUE}║      SociallyFed AI Workflow - Setup Wizard              ║${NC}"
    echo -e "${BLUE}║                                                          ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_step() {
    echo -e "${GREEN}►${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

###############################################################################
# Find Google Drive
###############################################################################

find_google_drive() {
    print_step "Looking for Google Drive..."
    
    # Common Google Drive locations
    local possible_paths=(
        "$HOME/Google Drive"
        "$HOME/GoogleDrive"
        "/mnt/GoogleDrive"
        "/Volumes/GoogleDrive"
        "$HOME/Library/CloudStorage/GoogleDrive"
    )
    
    for path in "${possible_paths[@]}"; do
        if [ -d "$path" ]; then
            echo "$path"
            return 0
        fi
    done
    
    return 1
}

configure_google_drive() {
    local gdrive_path
    
    # Try to auto-detect
    if gdrive_path=$(find_google_drive); then
        print_success "Found Google Drive at: $gdrive_path"
        echo ""
        read -p "Use this path? (y/n): " -n 1 -r
        echo ""
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            GOOGLE_DRIVE_PATH="$gdrive_path"
            return 0
        fi
    else
        print_warning "Could not auto-detect Google Drive location"
    fi
    
    # Manual entry
    echo ""
    print_info "Please enter the full path to your Google Drive folder:"
    print_info "Example: /Users/yourname/Google Drive"
    echo ""
    read -p "Path: " -r
    GOOGLE_DRIVE_PATH="$REPLY"
    
    # Verify path exists
    if [ ! -d "$GOOGLE_DRIVE_PATH" ]; then
        print_error "Directory does not exist: $GOOGLE_DRIVE_PATH"
        echo ""
        read -p "Create it anyway? (y/n): " -n 1 -r
        echo ""
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mkdir -p "$GOOGLE_DRIVE_PATH"
            print_success "Created directory: $GOOGLE_DRIVE_PATH"
        else
            print_error "Setup cannot continue without a valid Google Drive path"
            exit 1
        fi
    fi
    
    print_success "Using Google Drive path: $GOOGLE_DRIVE_PATH"
}

###############################################################################
# Create Directory Structure
###############################################################################

create_directory_structure() {
    print_step "Creating directory structure..."
    
    local base_dir="$GOOGLE_DRIVE_PATH/Development/SociallyFed"
    
    echo ""
    print_info "Will create directories in:"
    print_info "  $base_dir/"
    echo ""
    
    read -p "Continue? (y/n): " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Skipping directory creation"
        return 0
    fi
    
    # Create main directories
    local dirs=(
        "$base_dir/Context"
        "$base_dir/Reports/daily-briefs"
        "$base_dir/Reports/implementation-reports"
        "$base_dir/Active"
        "$base_dir/Archive"
    )
    
    for dir in "${dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            print_success "Created: $dir"
        else
            print_info "Already exists: $dir"
        fi
    done
    
    # Create initial context files if they don't exist
    if [ ! -f "$base_dir/Context/project-context.md" ]; then
        cat > "$base_dir/Context/project-context.md" << 'EOF'
# Project Context

## Project Overview
[Describe your project here]

## Current Goals
- [Goal 1]
- [Goal 2]

## Technical Stack
- [Technology 1]
- [Technology 2]

## Recent Decisions
- [Decision 1]
- [Decision 2]

---
*Last Updated: $(date +%Y-%m-%d)*
EOF
        print_success "Created initial project-context.md"
    fi
    
    echo ""
    print_success "Directory structure complete!"
}

###############################################################################
# Save Configuration
###############################################################################

save_configuration() {
    print_step "Saving configuration..."
    
    # Create config directory if it doesn't exist
    mkdir -p "$CONFIG_DIR"
    
    # Write configuration
    cat > "$CONFIG_FILE" << EOF
# SociallyFed AI Workflow Configuration
# Generated: $(date)

# Google Drive path
GOOGLE_DRIVE_PATH="$GOOGLE_DRIVE_PATH"

# Project paths
PROJECT_BASE="\$GOOGLE_DRIVE_PATH/Development/SociallyFed"
CONTEXT_DIR="\$PROJECT_BASE/Context"
REPORTS_DIR="\$PROJECT_BASE/Reports"
ACTIVE_DIR="\$PROJECT_BASE/Active"
ARCHIVE_DIR="\$PROJECT_BASE/Archive"

# Git configuration (optional - update as needed)
# GIT_USER_NAME="Your Name"
# GIT_USER_EMAIL="you@email.com"
EOF
    
    print_success "Configuration saved to: $CONFIG_FILE"
}

###############################################################################
# Make Scripts Executable
###############################################################################

make_scripts_executable() {
    print_step "Making scripts executable..."
    
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/scripts"
    
    if [ -d "$script_dir" ]; then
        chmod +x "$script_dir"/*.sh
        print_success "Scripts in $script_dir are now executable"
    else
        print_warning "Scripts directory not found: $script_dir"
    fi
}

###############################################################################
# Verify Setup
###############################################################################

verify_setup() {
    print_step "Verifying setup..."
    echo ""
    
    local all_good=true
    
    # Check configuration file
    if [ -f "$CONFIG_FILE" ]; then
        print_success "Configuration file exists"
    else
        print_error "Configuration file missing"
        all_good=false
    fi
    
    # Check Google Drive path
    if [ -d "$GOOGLE_DRIVE_PATH" ]; then
        print_success "Google Drive path accessible"
    else
        print_error "Google Drive path not accessible"
        all_good=false
    fi
    
    # Check project directories
    local base_dir="$GOOGLE_DRIVE_PATH/Development/SociallyFed"
    if [ -d "$base_dir/Context" ]; then
        print_success "Project directories created"
    else
        print_warning "Project directories may not be complete"
    fi
    
    # Check scripts
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/scripts"
    if [ -x "$script_dir/start-dev-session.sh" ]; then
        print_success "Scripts are executable"
    else
        print_warning "Some scripts may not be executable"
    fi
    
    echo ""
    
    if [ "$all_good" = true ]; then
        print_success "Setup verification passed!"
        return 0
    else
        print_warning "Setup completed with warnings"
        return 1
    fi
}

###############################################################################
# Show Next Steps
###############################################################################

show_next_steps() {
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                          ║${NC}"
    echo -e "${GREEN}║                  Setup Complete! 🎉                      ║${NC}"
    echo -e "${GREEN}║                                                          ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    print_info "Configuration saved to:"
    echo "  $CONFIG_FILE"
    echo ""
    
    print_info "Project directory created at:"
    echo "  $GOOGLE_DRIVE_PATH/Development/SociallyFed/"
    echo ""
    
    print_step "Next Steps:"
    echo ""
    echo "  1. Read the Quick Start Guide:"
    echo "     cat docs/QUICKSTART.md"
    echo ""
    echo "  2. Start your first development session:"
    echo "     ./scripts/start-dev-session.sh"
    echo ""
    echo "  3. Review the full documentation:"
    echo "     cat README.md"
    echo ""
    
    print_info "Need help? Check out:"
    echo "  • FAQ: docs/FAQ.md"
    echo "  • Troubleshooting: docs/TROUBLESHOOTING.md"
    echo "  • Issues: https://github.com/BennyGaming635/sociallyfed-ai-workflow/issues"
    echo ""
}

###############################################################################
# Main Setup Flow
###############################################################################

main() {
    print_header
    
    # Check if already configured
    if [ -f "$CONFIG_FILE" ]; then
        print_warning "Configuration already exists at: $CONFIG_FILE"
        echo ""
        read -p "Reconfigure? This will overwrite existing settings. (y/n): " -n 1 -r
        echo ""
        
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Setup cancelled. Existing configuration preserved."
            exit 0
        fi
    fi
    
    # Run setup steps
    configure_google_drive
    echo ""
    
    create_directory_structure
    echo ""
    
    save_configuration
    echo ""
    
    make_scripts_executable
    echo ""
    
    verify_setup
    
    show_next_steps
}

# Run main function
main "$@"
