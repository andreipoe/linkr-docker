# linkr-docker

This is a Docker wrapper for [the linkr URL shortener](https://github.com/LINKIWI/linkr). The image is based on `debian:jessie`, and the databse used for linkr is sqlite.

## Running the image

The image stores the databse in the `/data` volume and exposes port `80` for http connections. It is wise to set up https using a reverse proxy in front of it ([hint](https://www.nginx.com/resources/admin-guide/reverse-proxy/)).

The example below shows how to run linkr on port 10000 and store data in `/data/linkr`:

```
docker run -d --name linkr --restart=unless-stopped -p 10000:80 -v /data/linkr:/data linkr
```

You should now be able to connect to `http://localhost:10000` and use linkr. The default username is `admin` and the password is `password`; these can be changed in the linkr web settings.

## Building a custom image

Building a custom image allows you to:
 * Use a specific version of linkr.
 * Change the configuration files, including server and web client parameters, and the database username and password.
 * Set a custom admin username and password.

To build an image, first pull the repository and edit the linkr configuration files inside the `config` directory. These are the same as the templates provided with the linkr source code, and their documentation can be found on the [linkr GitHub page](https://github.com/LINKIWI/linkr). Any file that is removed or left unedited will be replaced by the default configuration. 

You probably want to set `linkr_url` (in `config/options/server.json`) to your domain name. For personal use, it might be wise to disable user registrations by setting `allow_open_registration` to `false` in the same file. Note that only sqlite databases are supported for now.

Next, the following build arguments are availble and can be given through the `--build-arg <arg>=<value>` syntax to `docker build`:
 * `version`: the linkr git version to use. This can be any _treeish_ that can be passed to `git checkout`. Default: `master`.
 * `admin_user`: the name of the intial administrator user. Default: `admin`.
 * `admin_pass`: the initial password of the admin user (can be changed later through the web interface). Default: `password`.

Below is a full example:

```
docker build -t linkr:f920a83 --build-arg version=f920a83 --build-arg admin_user=general --build-arg admin_pass=kenobi .
```

## TODO

 * Allow the other linkr database choices

