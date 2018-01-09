# MySQL Docker Image Without Volumes

This repo builds Docker images identical to those found from the [Official Docker Hub MySql Repository](https://hub.docker.com/r/library/mysql/).

The intention of this project is to act as a stopgap until Docker supports a method to unset volumes defined in parent images. _See https://github.com/docker-library/mysql/issues/255#issuecomment-353980071_ for context.

To build your own images you can do so by running the rebuild.sh script with your own namespace:

```bash
IMAGE_NAMESPACE=yourname rebuild.sh
```

This will pull in the [Docker Hub Library's code](https://github.com/docker-library/mysql/tree/master), modify the Dockerfiles to remove any volumes, then build the images.

## Links

Build source: [GitHub](https://github.com/codycraven/docker-mysql-novolume)

Docker images: [Docker Hub](https://hub.docker.com/r/codycraven/mysql-novolume/)
