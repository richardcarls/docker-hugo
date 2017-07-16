# Docker Hugo

Serve a Hugo site in a docker container. This image runs Hugo v0.25.1 on Alpine Linux 3.6.

## Usage
```bash
docker run -v /some/hugo/site:/hugo/site -p 1313:1313 richardcarls/hugo
```
Creates a user `hugo` with uid matching the mounted site directory and calls `hugo server` to start the built-in web server. It is recommended to define most server arguments in your config file at the site root. See [Configuring Hugo](https://gohugo.io/overview/configuration/) for all configuration options.

### Server
Due to the behavior of `hugo server`, you will need to specify `HUGO_BASE_URL` when running this image if not running on `localhost`
```bash
docker run -v /some/hugo/site:/hugo/site -e HUGO_BASE_URL=https://myblog.com/ -p 1313:1313 richardcarls/hugo
```
See [https://github.com/gohugoio/hugo/issues/1582]

Specifying `HUGO_BASE_URL` also causes `--appendPort=false` to be added to the command options. If you need a port to be appended, include it explicitly at the end of `HUGO_BASE_URL`.

### Running other Hugo commands
See the [Hugo Command Reference](https://gohugo.io/commands/) for all available commands. It's recommended to use `docker run` to avoid root ownership of generated files.

```bash
# Create a new Hugo site
docker run -it --rm -v /new/hugo/site:/hugo/site richardcarls/hugo new site .

# Create a new post (or whatever)
docker run -it --rm -v /new/hugo/site:/hugo/site richardcarls/hugo new post/top-10-floor-cleaning-products
```
