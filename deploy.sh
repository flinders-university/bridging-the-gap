#/bin/bash
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
  source "/usr/local/rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi
echo '* Updating bundle'
/home/aidancornelius/projects/bridging-the-gap/bin/bundle
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
bash -c "/usr/local/rvm/gems/ruby-2.3.1/bin/foreman start -f /home/aidancornelius/projects/bridging-the-gap/Procfile &" &
echo
echo '* Deploy Complete'
