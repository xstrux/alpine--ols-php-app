#export PROJECT_ID="<PROJECT_ID>"
#export IMAGE_NAME="<IMAGE_NAME>"

gcloud builds submit --tag gcr.io/$PROJECT_ID/$IMAGE_NAME --project $PROJECT_ID

# For testing only
docker pull gcr.io/$PROJECT_ID/$IMAGE_NAME
PORT=8080 && docker run --rm -it -p 8080:${PORT} -e PORT=${PORT} gcr.io/$PROJECT_ID/$IMAGE_NAME