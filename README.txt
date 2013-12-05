
http-conduit bug reproducer
---------------------------

This will error out after a few seconds / dozen fetches with something like this:

bug: InvalidStatusLine ...
bug: recv: invalid argument (Bad file descriptor)
bug: ZlibException (-3)
bug: OverlongHeaders

etc.

In the cabal file are commented out older dependencies that make it work again.

Note that the program will sooner or later error out on a 404 anyway.

