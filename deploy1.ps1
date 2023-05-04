$confirmation = Read-Host "Is it deployed for UAT(Y) or Production(n)? [Y/n]"
Write-Output "Starting flutter build for web.";
#flutter build web --web-renderer canvaskit;
flutter build web ;

if($confirmation -eq "y") {
    Write-Output "Starting deployment for UAT";

    Write-Output "Removing the old docker image patricktslee/uat-anchk-org:uat";
    docker image rm patricktslee/uat-anchk-org:uat;

    Write-Output "building the docker image patricktslee/uat-anchk-org:uat";
    #docker build --no-cache -t patricktslee/uat-anchk-org:uat -f Dockerfile2 .; 
    docker build -t patricktslee/uat-anchk-org:uat -f Dockerfile2 .; 

    Write-Output "pushing the docker image patricktslee/uat-anchk-org:uat";
    docker push patricktslee/uat-anchk-org:uat;

    Write-Output "stopping the kube service";
    kubectl delete -f uat-anchkorg.yml

    Write-Output "starting the kube service";
    kubectl apply -f uat-anchkorg.yml

   # Write-Output "checking the kube pod status";
   # while (1) {
   #     Clear-Host;
   #     kubectl get all -n uat-anchkorg;
   #     Start-Sleep 5;
   #}
}
else {
    Write-Output "Starting flutter build for web.";
    flutter build web --web-renderer canvaskit --release;

    Write-Output "Starting deployment for Production firebase";
    firebase deploy
}