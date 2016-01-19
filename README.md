Gitbox, a private mobile Github clone
=====================================

This is a hardware project to assist software development. The hardware comprises:

* [A Raspberry Pi model 2](https://www.adafruit.com/products/2358) for $40
* [128 GB USB stick](http://www.amazon.com/SanDisk-Ultra-128GB-Flash-SDCZ43-128G-G46/dp/B00YFI1EBC) for $28
* [8GB SD card with Raspbian Jessie](https://www.adafruit.com/products/2767) for $12
* [A 16x2 LCD display](https://www.adafruit.com/products/181) for showing the IP address, $10
* A backup battery circuit for graceful shutdown of the RPi
  - https://github.com/wware/rpi-shutdown
  - http://willware.blogspot.com/2016/01/graceful-shutdown-for-raspberry-pi.html
* Maybe a [nice case](http://www.adafruit.com/products/1985)? But I have some extra bits
  that it might not leave room for.

For now this will be a vanilla
[Git server](https://git-scm.com/book/en/v1/Git-on-the-Server) using
[GitWeb](https://git.wiki.kernel.org/index.php/Gitweb) as a web interface.
Later I might tinker with Gitlab or Gogs.

I did some tinkering in a Docker image before moving on to the physical RPi.

```bash
docker build -t gitbox .
docker run -d -p 80:80 -v /opt/git:/opt/git --name=gitbox gitbox
docker inspect --format='{{.NetworkSettings.IPAddress}}' gitbox
```

It's a good idea to put an entry for "gitbox" in `/etc/hosts` of your dev machine.

Creating a git repo is a bit of a chore. Given a repository foo, do this.

```bash
git clone --bare foo foo.git
scp -r foo.git gitbox:/opt/git/foo.git
```
