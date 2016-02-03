## External api rest documentation

## Prequisites

Before you can start working with this documentation please run - czy napewno????

```
bash install.sh
```

This will install Sculpin binaries required to run other commands of this project.

Alternatively you can install Sculpin manually using [this](https://sculpin.io/download/)

## Local testing

To verify locally if changes done look good run

```
publish testlocal.sh
```
Please take a note that due to certain Github assumptions and page structure images are not displayed on local version
(documentation on Github sits in sub-directory, while local version is in top-level directory)

## Automated deploy

To automatically deploy currently made changes perform desired changes simply run 

```
bash publish.sh documentation-update-name
```

Where `documentattion-update-run` is branch name to which changes will be pushed.

After script executes, please open a Pull Request in documentation repository [https://github.com/Transeu/api-rest-documentation/](https://github.com/Transeu/api-rest-documentation/)

Please also be aware that it will be required for development team to review changes and accept them before they will be published.

## Manual Deploy

1. Generate production ready documentation

    ```
    bin/sculpin install
    bin/sculpin generate --env=prod --url=http://transeu.github.io/api-rest-documentation
    ```    
    The site will be generated in `output_prod/`. 

2. Go to parent directory
    ```
    cd ..
    ```
3. Move generated documentation
    ```
    cp -rf __src/output_prod/* .
    ```
4. Commit and push changes
    ```
    git add .
    git commit -m 'documentation deploy'
    git push;
    
    ```
5. Clean up
    ```
    rm -rf __src/output_*
    ```
    
## Support

In case you have any questions or suggestions regarding this documentation please contact [api@trans.eu](mailto:api@trans.eu)