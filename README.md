## External api rest documentation

## Prequisites

Before you can start working with this documentation you only need to know markdown syntax.

Markdown syntax documentation is available [here](https://help.github.com/articles/basic-writing-and-formatting-syntax/)

## Local testing

To verify locally how changes made look run

```
bash testlocal.sh
```
Please take a note that due to certain Github assumptions and page structure images are not displayed on local version
(documentation on Github sits in sub-directory, while local version is in top-level directory)

## Automated deploy

To automatically deploy currently made changes perform desired changes simply run 

```
bash publish.sh documentation-update-name
```

Where `documentattion-update-name` is branch name to which changes will be pushed.

After script executes, please open a Pull Request in documentation repository [https://github.com/Transeu/api-rest-documentation/](https://github.com/Transeu/api-rest-documentation/)

Please also be aware that it will be required for development team to review changes and accept them before they will be published.

## Code review notes publishing

After content review has been done documentation content should be updated accordingly.

It is not necessary to publish them to new branch and create a new Pull Request.

It is possible to simply run

```
bash update.sh
```

and new content will be generated and pushed to current branch.

Important note - script will not allow to push changes directly to `gh-pages` branch.

## Manual Deploy

1. Generate production ready documentation

    ```
    cd _src
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
    cp -rf _src/output_prod/* .
    ```
4. Clean up
    ```
    rm -rf _src/output_*
    ```
5. Commit and push changes
    ```
    git add .
    git commit -m 'documentation update'
    git push
    
    ```

    
## Support

In case you have any questions or suggestions regarding this documentation please contact [api@trans.eu](mailto:api@trans.eu)