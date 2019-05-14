# SETTINGS

#export PROJECT_NAME="<PROJECT_NAME>"
#export PROJECT_VERSION="<PROJECT_VERSION>"
#export ECR_URL="<ECR_URL>"

# BUILD DOCKER IMAGE

export CONTAINER_REPOSITORY_URL="${ECR_URL}:${PROJECT_VERSION}"

echo "Building docker image for ${PROJECT_NAME} version ${PROJECT_VERSION}"

docker build -t ${CONTAINER_REPOSITORY_URL} .

docker images | grep ${ECR_URL} &> /dev/null

if [ $? == 0 ]; then

	echo "Docker image build successful."
	echo "Pushing image to AWS ECR - ${CONTAINER_REPOSITORY_URL}"

	bash -c 'eval $(aws ecr get-login --no-include-email --region ap-southeast-1)'
    docker push ${CONTAINER_REPOSITORY_URL}

    # deploy to EB
    eb deploy

    echo "====== Deployment completed. ======";

else
	echo "Docker build failed. Script terminated.";
fi