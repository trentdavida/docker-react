# docker-react

Mounting `/var/www/app` will over-write the default app with an empty folder. The app has been copied to `/tmp/app` so you can use `docker cp` to copy the default app to your volume mount. `node_modules` has a problem copying in windows, you me need to delete it from the `/tmp/app` before initiating the docker cp.

entrypoint by default checks for `/var/www/app/node_modules` and will run npm install if it doesn't find it. Then it checks for `cmd` if no arguments are passed, it defaults to running `npm start` otherwise it passes all arguments to `exec`
