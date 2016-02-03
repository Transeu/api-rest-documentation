## External api rest documentation

## Prequisites

Before you can start working with this documentation please run - czy napewno????

```
bash install.sh
```

This will install Sculpin binaries required to run other commands of this project.

Alternatively you can install Sculpin manually using [this](https://sculpin.io/download/)

## Build

```
bin/sculpin install
bin/sculpin generate --watch --server
```

External rest api documentation is now accessible at `http://localhost:8000/`.

## Automated deploy

To automatically deploy currently provided changes perform desired changes simply run 

```
bash publish.sh documentation-update
```

To verify locally if changes done look good run

```
publish testcontent.sh
```

## Manual Deploy

1. Generate production ready documentation

    ```
    bin/sculpin install
    bin/sculpin generate --env=prod --url=http://transeu.github.io/api-rest-documentation
    ```    
    The site will be generated in `output_prod/`. 

2. Clone transeu.github.io repository
    ```
    git clone git@github.com:Transeu/api-rest-documentation.git ../api-rest-documentation --branch gh-pages
    ```
3. Move generated documentation
    ```
    cp -rf output_prod/* ../api-rest-documentation
    ```
4. Commit and push changes
    ```
    cd ../api-rest-documentation
    git add .
    git commit -m 'documentation deploy'
    git push;
    ```
5. Clean up
    ```
    cd ../
    rm -rf api-rest-documentation
    ```