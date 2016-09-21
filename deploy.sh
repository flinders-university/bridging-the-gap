#/bin/bash
# Do not move this script! This deploys the Puma server on the remote host (git hook)
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
  source "/usr/local/rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi
echo '* Loading Secrets'
[[ -f ~/.environment_secrets ]] && . ~/.environment_secrets
echo '* Updating bundle'
/home/aidancornelius/projects/bridging-the-gap/bin/bundle
echo '* DB Migrations'
cd /home/aidancornelius/projects/bridging-the-gap && /home/aidancornelius/projects/bridging-the-gap/bin/rake db:migrate
echo '* Restarting Ruby server - Puma'
echo '** Killing existing server...'
for KILLPID in `ps ax | grep 'puma' | awk ' { print $1;}'`; do
  kill -9 $KILLPID > /dev/null;
done
echo '** Killing control protocol...'
for KILLPID in `ps ax | grep 'foreman' | awk ' { print $1;}'`; do
  kill -9 $KILLPID > /dev/null;
done
echo '** Restarting server...'
puma --dir /home/aidancornelius/projects/bridging-the-gap/ -C /home/aidancornelius/projects/bridging-the-gap/config/puma.rb &
echo
echo '* Deploy Complete'
