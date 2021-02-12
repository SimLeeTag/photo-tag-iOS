# Photo Tag - iOS Repository
<img src = "https://user-images.githubusercontent.com/58318786/96359589-80726000-114f-11eb-9e7a-c17f51b32cb1.png" width = "60%">

## Member
* BE: [Poogle(심수현)](https://github.com/suhyunsim)
* iOS: [Lena(이근나)](https://github.com/dev-Lena)
## Team Ground Rules  
[Team Ground Rules](https://github.com/SimLeeTag/Team/wiki/Ground-Rule)



<br/>

### Description

![](https://i.imgur.com/fSofvJD.jpg)
![](https://i.imgur.com/RT1h6N9.jpg)
![](https://i.imgur.com/LX6x5IJ.png)
<br/>

<br/>

## 📌 Convention
### Commit
>  [Reference](http://karma-runner.github.io/1.0/dev/git-commit-msg.html)

| Type | Contents |
|--|--|
|feat| new feature for the user, not a new feature for build script
|fix| bug fix for the user, not a fix to a build script
|docs| changes to the documentation
|refactor| refactoring production code, eg. renaming a variable
|style| formatting, missing semi colons, etc; no production code change
|test| adding missing tests, refactoring tests; no production code change)
|chore| updating grunt tasks etc; no production code change

- Example

    ```
    refactor: Refactor subsystem X for readability 

    {body...}

    #1 or resolves #1 // reference issues
    ```

### Branch - Git Flow
- default branch : `dev`
- `main`: production-ready state
- `dev`: latest delivered development changes for the next release
- `feat`: develop new features for the upcoming or a distant future release
- `deploy`: support preparation of a new production release
- `hotfix`: act immediately upon an undesired state of a live production version
- `{feat}/{feature}`
- Example

    ```
    feat/create-note
    ```
