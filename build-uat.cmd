@echo Removing the old docker image patricktslee/uat-anchk-org:uat
docker image rm patricktslee/uat-anchk-org:uat

@echo building the flutter web
flutter build web --web-renderer canvaskit --release

@echo building the docker image patricktslee/uat-anchk-org:uat
docker build -t patricktslee/uat-anchk-org:uat . 

@echo pushing the docker image patricktslee/uat-anchk-org:uat
docker push patricktslee/uat-anchk-org:uat

@echo stopping the kube service
kubectl delete -f uat-anchkorg.yml

@echo starting the kube service
kubectl apply -f uat-anchkorg.yml

@echo checking the kube pod status
kubectl get all -n uat-anchkorg