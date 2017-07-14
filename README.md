# Docker Hugo

Serve a Hugo site in a docker container. This image runs Hugo v0.25.1 on Alpine Linux 3.6.

## Usage
```bash
docker run -v /some/hugo/site:/hugo/site -p 1313:1313 richardcarls/hugo
```
Creates a user `hugo` with uid matching the mounted site directory and calls `hugo server` to start the built-in web server. It is recommended to define most server arguments in your config file at the site root. See [Configuring Hugo](https://gohugo.io/overview/configuration/) for all configuration options.

### Running other Hugo commands
See the [Hugo Command Reference](https://gohugo.io/commands/) for all available commands.

For example, to create a new Hugo site, start the container with the default command (named `some-hugo` in the below example), then:
```bash
docker exec some-hugo hugo new site .
```
