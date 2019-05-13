# IonicDocker

Add Dockerfile to your project root 

```
cd your/project/root/path
```

##### Using the docker image directly

Building the docker image
```
docker build -t ionic-builder:latest --no-cache .
```

Serving the app on 8100 to localhost for development
```
docker run --rm -v $(pwd):/ionicapp -p 8100:8100 ionic-builder:latest ionic serve
```

Using in interactive mode (expose the port to have on localhost)
```
docker run -t --rm -v $(pwd):/ionicapp ionic-builder:latest
```

Building APK for Android
```
docker run --rm -v $(pwd):/ionicapp ionic-builder:latest ionic build android
```

Using ionic cordova with newer versions
```
docker run --rm -v $(pwd):/ionicapp ionic-builder:latest ionic cordova build android
```

Useful alias to hide docker
```
 export alias ionicw='docker run --rm -v $(pwd):/ionicapp -p 8100:8100 ionic-builder:latest'
 ionicw ionic serve
```