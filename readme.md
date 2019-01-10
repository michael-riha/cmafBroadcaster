
## CMAF Broadcaster a remix of two Projects in a Container

 pretty much everything is copied from two sources, so all the credits to them.

 - https://github.com/streamlinevideo/low-latency-preview (@colleenkhenry)
 - https://github.com/jkarthic-akamai/ABR-Broadcaster/ (@jkarthic-akamai)

This project is just a tiny feasibility study!
Is is very limited at the moment, but I will add stuff. ;-)

### installation
_The project is very rudimentary for the moment._

build the docker container with
`docker build -t=<LABEL NAME eg. rihabitmovin/cmafbroadcaster> .`

### what is happening inside?

- ubuntu 18.04
- install some basic ubunutu packages needed for this project (python-minimal, python-pip, apache2, apache2-dev, aso)
- add a user `wsgi` (because apache screams if you start `mod_wsgi-express` as root)
- copy this project into the container (`server`, `install_scripts`, `test_scripts`)
- add him to sudo & give him some rights
- mount a volume where all the CMAF stuff is written to (manifest and segments)
- install prebuild ffmpeg & python libs (`install_scripts/requirements.txt`) and clean up
- start the Server
  - start `ffmpeg` with a `testsrc` and Timecode (no Audio!)
  - start embedded `mod_wsgi-express`
    - CORS config
    - map static ouput to `/out`
    - start the server from @jkarthic-akamai (it will not work because it is not prepared for running in a container) #TODO

### so what do it need it for?

it enables you at the moment to start a CMAF teststream with a teststream and outputs it via HTTP (not chunked but that is on the list!)

## how to run ?

``` docker run -it -p 8000:8000 -v <host absolute path>:/out <LABEL NAME eg. rihabitmovin/cmafbroadcaster>
```
you should now be able to open your browser `http://localhost:8000` which shows you the `Akamai Broadcaster` interface, which again, will NOT work because it should run on a maschine with hardware attached to produce a stream.

I do just use this `Akamai Broadcaster` as a kind of a webserver component for the time beeing. (STUPID but true!)

With the url `http://localhost:8000/static/manifest.mpd` you can now feed a player. It will also deliver all segments from there e.g `http://localhost:8000/static/chunk-stream-0-00001.m4s` aso.

## TODO

- use `Akamai Broadcaster` and contribute if possible
- enable chunked output in `webapp2` has to be written
- make it as extendable as possible

###credits:

 @colleenkhenry did a great job for me to set up a simple CMAF stream at the beginning
but since I am not familiar with `go` I skipped the Server part <br>
which would have been essential since CMAF has it's strength with `HTTP chunked encoding`.

This is a subject this project is completely missing at the moment!

@jkarthic-akamai thank for doing this great job on ffmpeg and for giving me so <br>
much ffmpeg commands as output from your server. I even sticked to your `pythong setup` with `mod_wsgi` <br>
but since I didn't want to mess up my maschine with a manually `ffmpeg` build, I remixed it with @colleenkhenry way to install.
