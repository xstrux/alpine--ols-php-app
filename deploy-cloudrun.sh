export PROJECT_ID="<PROJECT_ID>"
export IMAGE_NAME="<IMAGE_NAME>"

gcloud builds submit --tag gcr.io/$PROJECT_ID/$IMAGE_NAME --project $PROJECT_ID
#gcloud beta run deploy --image gcr.io/$PROJECT_ID/$IMAGE_NAME --project $PROJECT_ID