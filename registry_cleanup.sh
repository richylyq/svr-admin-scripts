#/bin/bash
## To use this script, put the shell file in the device where docker registry is located
## Make sure to change the docker registry file location accordingly

echo "Changing to directory: /media/docker/docker-registry/docker/registry/v2/repositories"
cd /media/docker/docker-registry/docker/registry/v2/repositories

echo "Showing folders"

for repo in */ ; do
    echo "REPO: ${repo}"
    cd ./${repo}_manifests/tags

    # find the total amt of SHA tags including user assigned tags 
    # and minus 3 to keep the 3 latest SHA
    total=($(find . -mindepth 1 -maxdepth 1 -type d | wc -l))
    echo "SHA total: ${total}"
    if [ $total -le 3 ]; then
       torm=0
    else
       torm=$(expr $total - 3)
    fi
    echo "SHA to remove ${torm}"

    # whilst keeping the latest 3 SHA and designated tags; remove the rest in the repository
    if [[ $? -eq 0 ]]
    then
        echo "CD: Success"
        top=($(ls -At | tail -n $torm | egrep -v 'latest|production|staging|main|development|release'))
        for file in ${top[@]} ; do
            echo "removing SHA ${file}"
            sudo rm -rf ${file}
        done

        cd ../../..
    else
        echo "CD: Failed"
    fi

done

docker exec -it docker-registry bin/registry garbage-collect --delete-untagged /etc/docker/registry/config.yml 
echo "Removed SHA tags"



