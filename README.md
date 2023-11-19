# proxmox_paperless


## Steps

1. Create a Ubuntu VM...

```text
agent: 1
bios: ovmf
boot: order=scsi0;ide2;net0
cores: 2
cpu: x86-64-v2-AES
efidisk0: local-zfs:vm-280-disk-0,efitype=4m,size=1M
ide2: remote:iso/ubuntu-22.04.3-live-server-amd64.iso,media=cdrom,size=2083390K
machine: q35
memory: 4096
meta: creation-qemu=8.0.2,ctime=1700381419
name: docs-1
net0: virtio=76:47:18:D1:D3:59,bridge=vmbr1,firewall=1
numa: 0
ostype: l26
scsi0: local-zfs:vm-280-disk-1,iothread=1,size=50G,ssd=1
scsihw: virtio-scsi-single
sockets: 1
startup: order=30
```

2. Start VM and run through Ubuntu installation...

- Enable LUKS and set a passphrase
- Enable OpenSSH server package
- Select Docker from the official snaps installs
- restart

3. Allow the Docker snap to install, restart.

4. Assign static IP address, restart.

5. Login via SSH and run `setup.sh`, restart.

6. Install Paperless-NGX...

```shell
bash -c "$(curl -L https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/install-paperless-ngx.sh)"
```
- URL []: http://docs-1.home
- Enable Apache Tika? (yes no) [no]: yes
- Everything else use defaults

7. Fix the buggy installer & setup user...

**NOTE** The script will end with an error: `http: invalid Host header`
         This seems to just be a bug.

```shell
cd paperless-ngx/
docker compose down
docker compose up --detach
...
docker exec -it paperless-webserver-1 bash
python manage.py createsuperuser
```

8. Try open the website and login: http://docs-1.home
