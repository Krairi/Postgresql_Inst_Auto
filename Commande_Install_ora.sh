lsblk
    8  sudo vgcreate vgora /dev/sdb
    9  lsblk
   10  sudo lvcreate -n soft -L 8G /dev/vgora
   11  sudo lvcreate -n data -L 6G /dev/vgora
   12  sudo mkfs.xfs /dev/vgora/backup
   13  sudo apt update
   14  sudo apt upgrade
   15  sudo apt install xfsprogs
   16  sudo mkfs.xfs /dev/vgora/backup
   17  sudo mkfs.xfs /dev/vgora/soft
   18  sudo mkfs.xfs /dev/vgora/data
   19  cd /etc/
   20  sudo vi fstab
   21  sudo mkdir /app
   22  sudo mkdir /oradata
   23  sudo mkdir /orabackup
   24  sudo mount -a
   25  lsblk
   26  sudo groupadd dba
   27  sudo groupadd oinstall
   28  sudo useradd -r -s /usr/bin/bash -g oinstall -G dba oracle
   29  id oracle
   30  history
   31  sudo apt install xfce4
   32  sudo apt update
   33  sudo apt install xfce4
   34  sudo reboot
   35  history
   36  df -h
   37  sudo mkdir -p /app/oracle/product/19.3/dbhome1
   38  cd /app/oracle/product/19.3/dbhome1/
   39  sudo unzip /home/djawed/LINUX.X64_193000_db_home.zip
   40  sudo unzip /home/djawed/LINUX.X64_193000_db_home.zip
   41  sudo apt search unzip
   42  sudo apt install unzip
   43  sudo ifdown ens33
   44  sudo ifup ens33
   45  sudo apt install unzip
   46  sudo unzip /home/djawed/LINUX.X64_193000_db_home.zip
   47  df -h
   48  sudo tune2fs -m 0 /dev/mapper/vgora-data
   49  sudo tune2fs -m 0 /dev/mapper/vgora-soft
   50  sudo tune2fs -m 0 /dev/mapper/vgora-backup
   51  df -h
   52  sudo apt search tune2fs
   53  history
   54  cd /app
   55  ls
   56  sudo chown -R oracle:oinstall oracle
   57  ls -l
   58  id oracle
   59  cd oracle/product/19.3/dbhome1/
   60  ls
   61  ls -l
   62  history
