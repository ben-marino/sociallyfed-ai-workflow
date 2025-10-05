#!/bin/bash

# provide-context.sh - Aggregate context for Claude Code implementation
# This script collects relevant context files and prepares them for Claude Code

set -euo pipefail

# Configuration
CONTEXT_DIR="${CONTEXT_DIR:-$HOME/Google Drive/SociallyFed/Context}"
PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"
EDITOR="${EDITOR:-code}"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Parse arguments
FEATURE="${1:-general}"
INCLUDE_FILES=()
shift || true
while [ $# -gt 0 ]; do
    INCLUDE_FILES+=("$1")
    shift
done

echo -e "${BLUE}🔄 Aggregating context for feature: ${YELLOW}$FEATURE${NC}"

# Output file
OUTPUT_FILE="$CONTEXT_DIR/development-context/DEVELOPMENT_CONTEXT.md"

# Function to get latest file from directory
get_latest_file() {
    local dir="$1"
    local pattern="${2:-*}"
    if [ -d "$dir" ]; then
        find "$dir" -name "$pattern" -type f -printf '%T@ %p\n' 2>/dev/null | sort -rn | head -1 | cut -d' ' -f2-
    fi
}

# Function to get recent files
get_recent_files() {
    local dir="$1"
    local days="${2:-3}"
    local pattern="${3:-*}"
    if [ -d "$dir" ]; then
        find "$dir" -name "$pattern" -type f -mtime -"$days" -printf '%T@ %p\n' 2>/dev/null | sort -rn | cut -d' ' -f2-
    fi
}

# Function to format file content
format_content() {
    local title="$1"
    local file="$2"
    
    if [ -f "$file" ]; then
        echo "## $title"
        echo ""
        echo "Source: \`$(basename "$file")\`"
        echo ""
        cat "$file"
        echo ""
        echo "---"
        echo ""
    fi
}

# Function to include specific project files
include_project_files() {
    if [ ${#INCLUDE_FILES[@]} -gt 0 ]; then
        echo "## Included Project Files"
        echo ""
        
        for pattern in "${INCLUDE_FILES[@]}"; do
            echo "### Files matching: $pattern"
            echo ""
            
            # Use find to match patterns
            while IFS= read -r file; do
                if [ -f "$file" ]; then
                    echo "#### $(basename "$file")"
                    echo '```'
                    cat "$file"
                    echo '```'
                    echo ""
                fi
            done < <(find "$PROJECT_DIR" -path "*/node_modules" -prune -o -path "*/.git" -prune -o -name "$pattern" -type f -print)
        done
        
        echo "---"
        echo ""
    fi
}

# Start building context
cat > "$OUTPUT_FILE" << EOF
# DEVELOPMENT CONTEXT

Generated: $(date +"%Y-%m-%d %H:%M:%S")
Feature Focus: $FEATURE

---

EOF

# Add latest daily brief
echo -e "${BLUE}📋 Adding latest daily brief...${NC}"
LATEST_BRIEF=$(get_latest_file "$CONTEXT_DIR/daily-briefs" "daily-brief-*.md")
if [ -n "$LATEST_BRIEF" ]; then
    format_content "Today's Daily Brief" "$LATEST_BRIEF" >> "$OUTPUT_FILE"
fi

# Add current development plan if exists
echo -e "${BLUE}📐 Checking for development plans...${NC}"
if [ "$FEATURE" != "general" ]; then
    FEATURE_PLAN="$CONTEXT_DIR/plans/plan-$FEATURE.md"
    if [ -f "$FEATURE_PLAN" ]; then
        format_content "Feature Plan: $FEATURE" "$FEATURE_PLAN" >> "$OUTPUT_FILE"
    fi
fi

# Add general development plan
LATEST_PLAN=$(get_latest_file "$CONTEXT_DIR/plans" "DEVELOPMENT_PLAN_*.md")
if [ -n "$LATEST_PLAN" ]; then
    format_content "Current Development Plan" "$LATEST_PLAN" >> "$OUTPUT_FILE"
fi

# Add recent implementation reports
echo -e "${BLUE}📊 Adding recent implementation reports...${NC}"
RECENT_REPORTS=$(get_recent_files "$CONTEXT_DIR/implementation-reports" 3 "report-*.md")
if [ -n "$RECENT_REPORTS" ]; then
    echo "## Recent Implementation Reports" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    
    while IFS= read -r report; do
        if [ -f "$report" ]; then
            echo "### $(basename "$report")" >> "$OUTPUT_FILE"
            echo "" >> "$OUTPUT_FILE"
            tail -n 50 "$report" >> "$OUTPUT_FILE"
            echo "" >> "$OUTPUT_FILE"
            echo "---" >> "$OUTPUT_FILE"
            echo "" >> "$OUTPUT_FILE"
        fi
    done <<< "$RECENT_REPORTS"
fi

# Add project conventions
echo -e "${BLUE}📚 Adding project conventions...${NC}"
CONVENTIONS_FILE="$CONTEXT_DIR/development-context/conventions.md"
if [ -f "$CONVENTIONS_FILE" ]; then
    format_content "Project Conventions" "$CONVENTIONS_FILE" >> "$OUTPUT_FILE"
else
    # Create default conventions if not exists
    cat > "$CONVENTIONS_FILE" << 'CONVENTIONS'
# SociallyFed Project Conventions

## Code Style
- Use dependency injection for all services
- Follow repository pattern for data access  
- Use MediatR for command/query separation
- All timestamps in UTC
- Log all external API calls

## Testing
- Minimum 80% test coverage
- Use xUnit for .NET tests
- Follow AAA pattern (Arrange, Act, Assert)
- Mock external dependencies

## Git Commits
- Conventional commits format
- Reference issue numbers
- Keep commits focused and atomic

## Security
- Never log sensitive data
- Encrypt data at rest
- Use parameterized queries
- Validate all inputs
CONVENTIONS
    format_content "Project Conventions" "$CONVENTIONS_FILE" >> "$OUTPUT_FILE"
fi

# Add architectural decisions
echo -e "${BLUE}🏗️  Checking for architectural decisions...${NC}"
ARCH_DECISIONS="$CONTEXT_DIR/development-context/architecture-decisions.md"
if [ -f "$ARCH_DECISIONS" ]; then
    format_content "Architectural Decisions" "$ARCH_DECISIONS" >> "$OUTPUT_FILE"
fi

# Add specific project files if requested
if [ ${#INCLUDE_FILES[@]} -gt 0 ]; then
    echo -e "${BLUE}📁 Including specific project files...${NC}"
    include_project_files >> "$OUTPUT_FILE"
fi

# Add instructions for Claude Code
cat >> "$OUTPUT_FILE" << 'INSTRUCTIONS'

## Instructions for Claude Code

1. Read this entire context document
2. Focus on the feature specified above
3. Follow all project conventions
4. Maintain 80%+ test coverage
5. Include comprehensive error handling
6. Add appropriate logging
7. Update relevant documentation

When implementing:
- Start with tests (TDD approach)
- Use existing patterns in the codebase
- Keep security and privacy as top priorities
- Optimize for clarity over cleverness

Remember: SociallyFed is a privacy-first application. All AI processing must remain local, and user data must be encrypted.

---

*This context was automatically generated by provide-context.sh*
INSTRUCTIONS

# Summary
echo -e "${GREEN}✅ Context aggregation complete!${NC}"
echo -e "${BLUE}📄 Context file: $OUTPUT_FILE${NC}"

# Count context size
WORD_COUNT=$(wc -w < "$OUTPUT_FILE")
LINE_COUNT=$(wc -l < "$OUTPUT_FILE")
echo -e "${BLUE}📊 Context size: ${YELLOW}$WORD_COUNT words, $LINE_COUNT lines${NC}"

# Open in editor
if [ -n "$EDITOR" ] && command -v "$EDITOR" &> /dev/null; then
    echo -e "${BLUE}📝 Opening context in $EDITOR...${NC}"
    "$EDITOR" "$OUTPUT_FILE" &
fi

# Provide usage instructions
echo ""
echo -e "${YELLOW}Usage with Claude Code:${NC}"
echo "\"Read DEVELOPMENT_CONTEXT.md and implement the $FEATURE feature according to the specifications.\""
echo ""
echo -e "${GREEN}Ready for implementation! 💻${NC}"