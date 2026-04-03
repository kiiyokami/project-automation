#!/bin/bash

set -e

# Source nvm if available
[ -f ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh

echo "Project Creation Automation Script"
echo "==================================="

# Prompt for base directory
read -p "Enter base directory for project [${HOME}]: " base_dir
base_dir="${base_dir:-$HOME}"

if [ ! -d "$base_dir" ]; then
    echo "Directory '$base_dir' does not exist."
    exit 1
fi

# Get and validate project name
read -p "Enter the project name: " project_name

if [ -z "${project_name// /}" ]; then
    echo "Project name cannot be empty."
    exit 1
fi

# Replace spaces with underscores
project_name="${project_name// /_}"

project_path="$base_dir/$project_name"

# Handle existing directory
if [ -d "$project_path" ]; then
    read -p "Directory '$project_name' already exists. Delete it? (y/n): " confirm_delete
    if [ "$confirm_delete" != "y" ]; then
        echo "Aborting."
        exit 1
    fi
    rm -rf "$project_path"
fi

mkdir "$project_path"
cd "$project_path"

clear
echo "Choose a template"
echo "================="

echo "(1) Frontend Template (2) Backend Template"
read -p "Enter your choice: " template
clear

case $template in
    1)
        echo "Frontend Template Selected"
        echo "==========================="
        if ! command -v npm &>/dev/null; then
            curl -qL https://www.npmjs.com/install.sh | sh
            [ -f ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh
        fi
        npm init vite@latest .
        npm install
        cat > .gitignore << 'EOF'
node_modules/
dist/
.env
*.log
EOF
        git init
        echo "Frontend project created. Run 'npm run dev' to start development server."
        ;;
    2)
        echo "Backend Template Selected"
        echo "==========================="
        echo "Choose a language"
        echo "(1) Node.js (2) Python (3) Go (4) Rust"
        read -p "Enter your choice: " language
        clear
        case $language in
            1)
                echo "Node.js Template Selected"
                echo "Do you want to use npm, deno, or bun?"
                echo "(1) npm (2) deno (3) bun"
                read -p "Enter your choice: " npm_or_deno_or_bun
                clear
                case $npm_or_deno_or_bun in
                    1)
                        if ! command -v npm &>/dev/null; then
                            curl -qL https://www.npmjs.com/install.sh | sh
                            [ -f ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh
                        fi
                        echo "Using npm init"
                        npm init -y
                        touch index.js
                        cat > .gitignore << 'EOF'
node_modules/
dist/
.env
*.log
EOF
                        git init
                        ;;
                    2)
                        if ! command -v deno &>/dev/null; then
                            curl -fsSL https://deno.land/install.sh | sh
                            [ -f "$HOME/.deno/env" ] && source "$HOME/.deno/env"
                        fi
                        git clone git@github.com:lampewebdev/deno-boilerplate.git .
                        git remote remove origin
                        ;;
                    3)
                        if ! command -v bun &>/dev/null; then
                            curl -fsSL https://bun.sh/install | bash
                            [ -f "$HOME/.bun/env" ] && source "$HOME/.bun/env"
                        fi
                        git clone git@github.com:RajaRakoto/bun-boilerplate.git .
                        git remote remove origin
                        ;;
                    *)
                        echo "Invalid choice"
                        exit 1
                        ;;
                esac
                ;;
            2)
                echo "Python Template Selected"
                git clone git@github.com:Dugnist/python-pipenv-starter.git .
                git remote remove origin
                ;;
            3)
                echo "Go Template Selected"
                git clone git@github.com:codoworks/go-boilerplate .
                git remote remove origin
                cat > .gitignore << 'EOF'
*.exe
*.out
/bin/
vendor/
EOF
                ;;
            4)
                echo "Rust Template Selected"
                if ! command -v cargo &>/dev/null; then
                    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
                    source "$HOME/.cargo/env"
                fi
                cargo init .
                cat > .gitignore << 'EOF'
/target/
EOF
                git init
                ;;
            *)
                echo "Invalid choice"
                exit 1
                ;;
        esac
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo "Project '$project_name' created successfully!"

read -p "Open project folder in file manager? (y/n): " open_fm
if [ "$open_fm" == "y" ]; then
    xdg-open .
fi

read -n 1 -r -p "Press any key to exit..."
echo
exit 0
