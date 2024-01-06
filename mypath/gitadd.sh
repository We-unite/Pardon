#!/bin/bash

read -p "Local repo name: " local_name
read -p "Remote repo name: " remote_name

# 远程仓库创建
tmp="ssh aliyun-git git init --bare $remote_name.git"
eval "$tmp"

# 本地仓库创建
mkdir "$local_name"
cd "$local_name"
git init

# 本地仓库初始化
# 编写.gitignore
cat > .gitignore << EOF
*.sh
*.bat
*.exe
*.[oa]
*.pyc
__pycache__
*.vscode
*.swp
EOF

# 编写push.sh
cat > push.sh << EOF
git add .
git commit
git push
EOF
chmod +x push.sh

# 提交初始化commit
git add .
git commit -m "Initial commit"
tmp="git remote add origin aliyun-git:$remote_name.git"
eval "$tmp"
git push --set-upstream origin master
git push

echo "Success!"

