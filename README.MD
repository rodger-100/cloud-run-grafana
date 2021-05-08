## Cloud run / Knative Docker image for grafana

This repo is to build the Grafana Dashboard on Knative or google cloud run so that everything is backed into the docker and you will have read only grafana link for your pitch

```
docker build . -t my-g
docker run -d -p 8008:3000  my-g
```

This you want to push the image to GCR 
```
docker build . -t gcr.io/cloud-run-test-241704/grafana
docker push gcr.io/cloud-run-test-241704/grafana
```
