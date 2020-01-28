# Heroku Container Runtime Release Phase Demo

## Purpose

Demonstrate that the log output and return status of the `CMD` run in the release container are ignored.

## Usage

Ensure that you have Docker and and the Heroku client installed, and that you are logged into the Heroku container registry. Create a new Heroku application, noting it's name. Then build and push the application:

```bash
 $ HEROKU_APP_NAME='my-test-apps-name' ./push-image.sh
```

Now, check the Heroku dashboard. The expected result is that the application has failed to release due to the non-zero exit status returned by `./bin/do-release-tasks.sh`, and that the release logs contain `Aborting release`. The current result is that the release succeeds, and the release log is empty.
