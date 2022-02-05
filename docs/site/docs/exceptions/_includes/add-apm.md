


:::info 
Note: All of the commands below should be run in a terminal / command prompt in the root directory of your application, generally the level above your source directory.
:::

**If you don't have an APM project setup, expand the guide below to setup an APM project before installing the extension.**

<details><summary>Setup APM</summary>
<p>

### Install APM

If you haven't installed `apm` follow the install guide on [airsdk.dev](https://airsdk.dev/docs/basics/install-apm).


### Setup an APM project 

You will need an APM project for your application.


There are many ways to do this and for more options see the [APM documentation](https://github.com/airsdk/apm/wiki/Usage-ProjectsAndPackages#initialise). Here we will just initialise a new empty project:

```
apm init
```

#### Check your github token

We use github to secure our extensions so you must have created a github personal access token and configured `apm` to use it. 

To do this create a token using this [guide from github](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token) and then set it in your apm config using:

```
apm config set github_token ghp_XXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

If you don't do this correctly you may find the install will fail.

</p>
</details>


### Install the extension 

Install the extension by running: 

```
apm install com.distriqt.Exceptions
```

This will download and install the extension, required assets, and all dependencies.

Once complete `apm` will have created something like the following file structure: 

```
.
|____ ane
| |____ com.distriqt.Exceptions.ane		# Exceptions extension
| |____ [dependencies]
|____ apm_packages						# cache directory - ignore
|____ project.apm						# apm project file
```

- Add the `ane` directory to your IDE. *See the tutorials located [here](/docs/tutorials/getting-started) on adding an extension to your IDE.*

:::info
We suggest you use the locations directly in your builds rather than copying the files elsewhere. The reason for this is if you ever go to update the extensions using `apm` that these updates will be pulled into your build automatically.
:::


