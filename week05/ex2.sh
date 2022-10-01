mkdir -p backups

cd backups

name="home_backup_$(date -u +%b_%d_%Y_%H_%M_%S).tar.gz"
tar -czvf $name ~

cd ..

