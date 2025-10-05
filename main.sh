#!/bin/bash

# source sourcing out bashrc and compilers
source ~/.bashrc
source ~/.nvm/nvm.sh

echo Project Creation Automation Script
echo ===========================

#Move out of the current directory
cd ..


#Create the project directory
read -p "Enter the project name: " project_name


# Check if project name has spaces, then replace with underscore
if [[ $project_name == *" "* ]]; then
    project_name=${project_name// /_}
fi

if [ -d "$project_name" ]; then
    rm -rf $project_name
fi

mkdir $project_name
cd $project_name

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
        curl -qL https://www.npmjs.com/install.sh | sh
        npm init vite@latest .
        npm install
        git init
        echo "Frontend project created. Run 'npm run dev' to start development server."
        ;;
    2)
        echo "Backend Template Selected"
        echo "==========================="
        echo "Choose a language"
        echo "(1) Node.js (2) Python (3) Go"
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
                        curl -qL https://www.npmjs.com/install.sh | sh
                        source ~/.bashrc
                        echo "npm installed, using npm init"
                        npm init -y
                        touch index.js
                        git init
                        ;;
                    2)
                        curl -fsSL https://deno.land/install.sh | sh
                        git clone git@github.com:lampewebdev/deno-boilerplate.git .
                        git remote remove origin
                        git init
                        ;;
                    3)
                        curl -fsSL https://bun.sh/install | bash
                        git clone git@github.com:RajaRakoto/bun-boilerplate.git .
                        git remote remove origin
                        git init
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
                git init
                ;;
            3)
                echo "Go Template Selected"
                git clone git@github.com:codoworks/go-boilerplate .
                git remote remove origin
                git init
                ;;
        esac
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo "Project '$project_name' created successfully!"

read -p "Open project in VSCode? (y/n): " open_in_vscode
if [ "$open_in_vscode" == "y" ]; then
    code .
else
    echo "Exiting..."
fi

read -p "Press any key to exit..."
exit 0
