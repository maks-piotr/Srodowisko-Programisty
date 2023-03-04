r1=$1
r2=$2
remote_repo=$3
echo "Rewizje $1-$2"

rm -rf /tmp/git_repo &> /dev/null
mkdir /tmp/git_repo
git init /tmp/git_repo

for i in $(seq $r1 $r2)
do
   rm -r /tmp/git_repo/* &> /dev/null
   svn export --force -r $i $remote_repo /tmp/git_repo/ > /dev/null
   commit_message=$(svn log -r $i $remote_repo | head -n -2 | tail -n +4 )
   echo Dodano commit $i: $commit_message
   git -C /tmp/git_repo add -A
   git -C /tmp/git_repo commit --allow-empty --allow-empty-message -m "$commit_message" > /dev/null
done

mv /tmp/git_repo ./git_repo
