Setting up the Gitbox
====

Copy the file `gitbox.sh` into `/etc/init.d` and run
```bash
update-rc.d gitbox.sh defaults
```

USB stick
----

It was probably a mistake, but I used parted `mkpart primary ext4 0 -1` to put an
ext4 filesystem on the big USB stick. The filesystem ended up corrupted somehow
and I needed to do this.
```bash
mke2fs -S /dev/sda1              # rewrite superblocks
e2fsck -y -p -b 32768 /dev/sda1  # clean up inodes
```

I added this line to /etc/fstab:
```
/dev/sda1       /opt/git        ext4    rw   0 0
```

and I had to do [these things](http://www.htpcguides.com/properly-mount-usb-storage-raspberry-pi/):
```bash
sudo chown -R pi:pi /opt/git
sudo chmod -R 775 /opt/git
sudo mount /opt/git
sudo setfacl -Rdm g:pi:rwx /opt/git
sudo setfacl -Rm g:pi:rwx /opt/git
```

But finally it's working, and I have the thing going with wifi in the office.
Only 114 GB of the USB stick is available but that should keep me happy for a
little while.
