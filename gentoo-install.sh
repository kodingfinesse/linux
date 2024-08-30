sudo swapon /dev/nvme0n1p3 && sudo mount --types proc /proc /mnt/gentoo/proc && sudo mount --rbind /sys /mnt/gentoo/sys && sudo mount --make-rslave /mnt/gentoo/sys && sudo mount --rbind /dev /mnt/gentoo/dev && sudo mount --make-rslave /mnt/gentoo/dev

sudo cp -u /etc/resolv.conf /mnt/gentoo/etc/ && sudo chroot /mnt/gentoo
env-update && source /etc/profile && export PS1="(chroot) $PS1"
emaint sync -A && emerge --oneshot portage
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && sudo emerge app-portage/cpuid2cpuflags && sudo cpuid2cpuflags

cat << EOF > /etc/portage/make.conf
CFLAGS="-march=znver3 -mtune=znver3 -O3 -pipe"
CXXFLAGS="${CFLAGS}"
CHOST="x86_64-pc-linux-gnu"
CPU_FLAGS_X86="aes avx avx2 f16c fma3 mmx mmxext pclmul popcnt rdrand sha sse sse2 sse3 sse4_1 sse4_2 sse4a ssse3 vpclmulqdq"
GRUB_PLATFORMS="efi-64"
ACCEPT_KEYWORDS="~amd64"
ACCEPT_LICENSE="*"
MAKEOPTS="-j13 -l9"
FEATURES="ccache getbinpkg buildpkg parallel-fetch parallel-install ebuild-locks"
EMERGE_DEFAULT_OPTS="--keep-going --binpkg-respect-use=y --with-bdeps=y --backtrack=100"
GENTOO_MIRRORS="https://mirror.leaseweb.com/gentoo/ http://gentoo-mirror.flux.utah.edu/"
VIDEO_CARDS="amdgpu"
AUTOCLEAN="yes"
EOF

eselect profile list && sudo eselect repository list && eselect repository enable gentoobr && eselect repository enable elementary && emaint sync -A && emerge -DNju @world && emerge -c

## configure os-prober to mount grub
cat << 'EOF' > /etc/portage/package.use/os-prober
>=sys-boot/grub-2.06-r7 mount
EOF

## install useful apps
emerge -DNju vim bash-completion btrfs-progs
emerge -DNju app-portage/eix app-portage/gentoolkit sys-process/htop sys-process/lsof sys-boot/os-prober

## install vanilla sources and genkernel-next
mkdir -p /etc/portage/package.license

cat << 'EOF' > /etc/portage/package.license/linux-firmware
sys-kernel/linux-firmware linux-fw-redistributable no-source-code
EOF

emerge -DNju genkernel sys-kernel/gentoo-sources sys-kernel/linux-firmware

## Remember to enable:
## 	 * all virtio devices; at least: virtio_pci and virtio_blk
##	 * btrfs support
genkernel --menuconfig --btrfs --virtio all

# Configure real root and stuff
# Do not forget to append systemd to the kernel command line: GRUB_CMDLINE_LINUX="real_init=/lib/systemd/systemd quiet"
vim /etc/default/grub

## install grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi

# update grub
grub-mkconfig -o /boot/grub/grub.cfg

# systemd
## Setup machine ID to activate journaling
systemd-machine-id-setup

## DHCP
cat << 'EOF' > /etc/systemd/network/20-default.network
[Match]
Name = enp*
[Network]
DHCP = yes
EOF

systemctl enable systemd-networkd.socket

# set root password
passwd

# reboot (and pray, think wishfully, cross your fingers or whatever you do to influence reality... not!)
reboot

# after reboot
## set hostname
# hostnamectl set-hostname my.example.tld

## set locale (after reboot)
# localectl set-locale LANG=<LOCALE>

## set time and date
# timedatectl --help
