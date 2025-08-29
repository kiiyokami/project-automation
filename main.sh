#!/bin/bash

echo Project Creation Automation
echo =========================

#Move out of the current directory
cd ..

# Create a new project
echo What is the name of the project?
read PROJECT_NAME

# Create a new directory
mkdir $PROJECT_NAME
cd $PROJECT_NAME

# Ask for the project type
echo What type of project is this?
echo [1] Frontend
echo [2] Backend
read PROJECT_TYPE

if [ $PROJECT_TYPE -eq 1 ]; then
    echo Frontend Project
    echo ================
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
    </html>" > index.html

    echo "body {
        background-color: black;
        color: white;
    }" > style.css
    echo "console.log('Hello, World!');" > script.js
    
elif [ $PROJECT_TYPE -eq 2 ]; then
    echo Backend Project
    echo ===============
    # Ask for the programming language
    echo What programming language is this?
    echo [1] TypeScript
    echo [2] Python
    echo [3] Golang
    read PROJECT_LANGUAGE

    if [ $PROJECT_LANGUAGE -eq 1 ]; then
        echo TypeScript Project
        echo =================
        #Create project files
        touch index.ts
        # Add boilerplate code
        echo "import express from 'express';
        const app = express();
        const port = 3000;
        app.listen(port, () => {
            console.log(\`Server is running on port \${port}\`);
        });" > index.ts
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
        }" > tsconfig.json
        #Create package.json
        touch package.json
        #Compile the TypeScript files
        tsc index.ts
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
            return 'Hello, World!'" > main.py
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