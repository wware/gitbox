Gitbox, a private mobile Github clone
=====================================

This is a hardware project to assist software development. The hardware comprises:

* A Raspberry Pi model B+
* 128 GB USB stick for $28 - http://www.amazon.com/SanDisk-Ultra-128GB-Flash-SDCZ43-128G-G46/dp/B00YFI1EBC
* A 16x2 LCD display for showing the IP address
* A backup battery circuit for graceful shutdown of the RPi
* Maybe a nice case? http://www.adafruit.com/products/1985

The backup battery circuit has the job of detecting that the power cord has been pulled,
telling the RPi to shut down, and supplying auxiliary power until shutdown is finished.

![Shutdown circuit schematic](https://raw.githubusercontent.com/wware/gitbox/master/RPiPowerDown2.png)

I spent some time playing with both Gitlab and Gogs, and ultimately
settled upon a vanilla
[Git server](https://git-scm.com/book/en/v1/Git-on-the-Server) using
[GitWeb](https://git.wiki.kernel.org/index.php/Gitweb) as a web interface.

For the time being, I am mostly tinkering in a Docker image before I move on
to actual RPi development.

```bash
docker build -t gitbox .
docker run -d -p 80:80 -v /opt/git:/opt/git --name=gitbox gitbox
docker inspect gitbox | grep IPAddress
```

It's a good idea to put an entry for "gitbox" in `/etc/hosts`.

Creating a git repo is a bit of a chore. Given a repository foo, do this.

```bash
git clone --bare foo foo.git
scp -r foo.git gitbox:/opt/git/foo.git
```
