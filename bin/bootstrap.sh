# styling
TITLE="\033[1;37m\033[46m"
NORMAL="\033[0;39m"
BOLD_RED="\033[0;1;31m"
GREEN="\033[32m"
YELLOW="\033[33m" 

node_version=11

function title {
  echo
  echo $TITLE$1$NORMAL
}

function success {
  echo $GREEN$1$NORMAL
}

function error {
  echo $BOLD_RED$1$NORMAL
}

function instructions {
  echo $YELLOW$1$NORMAL
}

title "Checking for Global Dependencies"

# Git
if which git &> /dev/null
then
  success "✔ Git is installed: OK!😻"
else
  error "  You need to install git first!😳"
  exit
fi

# Docker
if which docker &> /dev/null
then 
  success "✔ Docker is installed: OK!🧐"
else
  error "Docker is not installed please check https://www.docker.com/products/docker-desktop (use cmd + click to open link)🤗"
  exit
fi

# docker-compose
if which docker-compose &> /dev/null
then 
  success "✔ docker-compose is installed: OK!😍"
else
  error "Please install docker-compose!🤔"
  exit
fi

# nvm
if [ $(which nvm | grep "not found") ]
then
  error "installing nvm..."
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
  error "Please restart terminal 😱"
  exit
else
  success "✔ nvm is installed: OK!😋"
fi


# node
if [ $(node -v | grep "v${node_version}") ]
then 
  success "✔ You got Node ${node_version}!🙃"
else
  error "Installing Node ${node_version}"
  nvm install ${node_version}
  nvm run node ${node_version}

  if [ $(node -v | grep "v${node_version}") ]
  then
    success "✔ You got Node ${node_version}!🙃"
  else
    error "Installation unsuccessful Please install Node ${node_verion} manually!"
    exit
  fi
fi

# yarn
if which yarn &> /dev/null
then 
  success "✔ yarn is installed: OK!😌"
else
  error "Installing yarn"
  curl -o- -L https://yarnpkg.com/install.sh | bash
  success "Yarn installed successfully! Please restart your terminal 😃😃"
  exit
fi

title "Pull Latest Version From Master"
# The return value is stored in $?. 0 indicates success, others indicates error.
git pull origin master
if [ $? -eq 0 ]
then 
  success "I pulled the latest version from master! 😉"
else
  error "I couldn't pull!"
  exit
fi

title "Install Local Dependencies"
yarn
if [ $? -eq 0 ]
then 
  success "All local dependencies are installed! 😀"
else
  error "I couldn't install local dependencies!"
fi

title "Further Instructions"
echo ""
instructions "Run 'docker-compose up' to start the database and prisma endpoint 'localhost:4466'"
instructions "In a new tab, run 'yarn deploy' to set up the database tables and generate ts types for all models"
instructions "Run'yarn dev' to start the dev server on 'localhost:4000'"
echo ""

