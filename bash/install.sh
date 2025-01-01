# install node/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
wait
nvm install node
# install pyenv
curl https://pyenv.run | bash
wait
pyenv update
pyenv install 3.12.5
# create pyenv venv
wait
pyenv virtualenv 3.12.5 openai_env
pyenv activate openai_env
# install requirements
pip install -r ai/requirements.txt
# deactivate venv
pyenv deactivate
# copy ai files to .devenv directory
cp ../ai/ai.py $HOME/.devenv/ai.py
cp ../ai/.response.md $HOME/.devenv/.response.md
cp ../ai/.system.md $HOME/.devenv/.system.md
cp ../ai/.user.md $HOME/.devenv/.user.md
cp ../ai/chat.sh $HOME/.devenv/chat.sh

