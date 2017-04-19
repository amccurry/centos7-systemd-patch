FROM centos
RUN yum -y update
RUN yum -y install \
  wget \
  rpm-build \
  libcap-devel \
	tcp_wrappers-devel \
	pam-devel \
	libselinux-devel \
	audit-libs-devel \
	cryptsetup-devel \
	dbus-devel \
	libacl-devel \
	pciutils-devel \
	glib2-devel \
	gobject-introspection-devel \
	libblkid-devel \
	xz-devel \
	zlib-devel \
	bzip2-devel \
	libidn-devel \
	libcurl-devel \
	kmod-devel \
	elfutils-devel \
	libgcrypt-devel \
	gnutls-devel \
	qrencode-devel \
	libmicrohttpd-devel \
	libxslt \
	docbook-style-xsl \
	intltool \
	gperf \
	gtk-doc \
	python2-devel \
	python-lxml \
	automake \
	autoconf \
	libtool \
	git \
	libmount-devel

WORKDIR /root

COPY rebuild_rpm.sh /root
COPY systemd-docker-unpriv.patch /root

VOLUME [ "/output" ]
CMD [ "/root/rebuild_rpm.sh" ]
