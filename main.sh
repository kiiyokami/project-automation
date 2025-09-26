#!/bin/bash

# source sourcing out bashrc and compilers
source ~/.bashrc
source ~/.bash_profile
source ~/.nvm/nvm.sh

echo Project Creation Automation
echo =========================

#Move out of the current directory
cd ..

# Loop until the user enters a valid project name
while true; do
  echo Enter the project name:
  echo =========================
  read PROJECT_NAME

  # Check if the project name is valid
  if [ -d "$PROJECT_NAME" ]; then
    echo "Project name already exists. Please choose a different name."
    continue
  # Check if project name has a space
  elif [[ "$PROJECT_NAME" == *" "* ]]; then
    echo "Project name cannot contain spaces. Please choose a different name."
    continue
  else
    break
  fi
done

# Create a new directory
mkdir $PROJECT_NAME
cd $PROJECT_NAME


# Initialize the git repository
git init
clear

# Ask for the project type
echo What type of project is this?
echo [1] Frontend (Static File Hosting Only)
echo [2] Backend (For TypeScript, Python, or Golang)
echo =========================
read PROJECT_TYPE

if [ $PROJECT_TYPE -eq 1 ]; then
  echo Creation in progress...
  #Create project files
  touch index.html
  touch style.css
  touch script.js
  mkdir assets

  #Add boilerplate code
  echo "<!DOCTYPE html>
    <html>
        <head>
            <title>Hello, World!</title>
            <link rel=\"stylesheet\" href=\"style.css\">
        </head>
        <body>
            <h1>Hello, World!</h1>
            <script src=\"script.js\"></script>
        </body>
    </html>" >index.html

  echo "body {
        background-color: black;
        color: white;
    }" >style.css
  echo "console.log('Hello, World!');" >script.js

  echo "Successfully created the project files."

elif [ $PROJECT_TYPE -eq 2 ]; then
  echo Backend Project
  echo ===============
  # Ask for the programming language
  echo What programming language is this?
  echo [1] TypeScript
  echo [2] Python
  echo [3] Golang
  echo =========================
  read PROJECT_LANGUAGE

  if [ $PROJECT_LANGUAGE -eq 1 ]; then
    echo Creation in progress...
    #Create project files
    touch index.ts
    # Add boilerplate typescript + express code
    echo "import express from 'express';
    const app = express();
    app.get('/', (req: express.Request, res: express.Response) => {
    res.send('Hello, World!');
    });
    app.listen(3000, () => {
    console.log('Server is running on port 3000');    
    });" >index.ts
    
    # Add a tsconfig.json file
    touch tsconfig.json
    # Add a compilerOptions section to the tsconfig.json file
    echo "{
    \"compilerOptions\": {
    \"target\": \"es5\",
    \"module\": \"commonjs\",
    \"strict\": true,
    \"esModuleInterop\": true,
    \"skipLibCheck\": true,
    \"forceConsistentCasingInFileNames\": true
    }
        }" >tsconfig.json
    #Run npm init
    npm init -y
    #Install express and typescript dependency
    npm install express
    npm i --save-dev @types/express
    #Install typescript
    npm install typescript
    #Install ts-node
    npm install ts-node

    #Compile the TypeScript files
    npx tsc

    # Gitignore compiled files
    echo "node_modules/
    index.js
    package-lock.json
    dist" >.gitignore

    echo "Successfully created the project files."
    echo "You can now run the server using the command 'node index.js'."
    echo "The server will be running on port 3000."
    echo "Press any key to exit."
    read
    exit
  elif [ $PROJECT_LANGUAGE -eq 2 ]; then
    echo Python Project
    echo =============
    #Create pipenv
    pipenv install
    #Configure pipenv
    pipenv shell
    #Create project files
    touch main.py
    # Add boilerplate code
    echo "from flask import Flask
    app = Flask(__name__)
    @app.route('/')
    def hello_world():    
    return 'Hello, World!'" >main.py
    touch requirements.txt
    touch Pipfile
    touch Pipfile.lock
  elif [ $PROJECT_LANGUAGE -eq 3 ]; then
    echo Golang Project
    echo =============
    #Create project files
    touch main.go
    touch go.mod
    touch go.sum
  fi
fi

echo Do you want to open the project directory in VS Code?
echo [1] Yes
echo [2] No
read OPEN_PROJECT

if [ $OPEN_PROJECT -eq 1 ]; then
  code .
fi

