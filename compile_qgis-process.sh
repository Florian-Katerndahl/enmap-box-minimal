# compilation as per https://github.com/qgis/QGIS/blob/master/INSTALL.md
# Step 1: install dependencies, clone QGIS-repository and build into /usr/bin
sed -i 's/# deb/deb/g' /etc/apt/sources.list

apt update

# currently, only qgis dependencies and not those from enmap-box
# added missing g++
# "--no-install-suggests --no-install-recommends" reduce N° of packages by ~400
apt install --no-install-suggests --no-install-recommends \
  bison ca-certificates ccache cmake cmake-curses-gui dh-python \
  doxygen expect flex flip gdal-bin git graphviz grass-dev g++ libexiv2-dev \
  libexpat1-dev libfcgi-dev libgdal-dev libgeos-dev libgsl-dev libpdal-dev \
  libpq-dev libproj-dev libprotobuf-dev libqca-qt5-2-dev libqca-qt5-2-plugins \
  libqscintilla2-qt5-dev libqt5opengl5-dev libqt5serialport5-dev libqt5sql5-sqlite \
  libqt5svg5-dev libqt5webkit5-dev libqt5xmlpatterns5-dev libqwt-qt5-dev \
  libspatialindex-dev libspatialite-dev libsqlite3-dev libsqlite3-mod-spatialite \
  libyaml-tiny-perl libzip-dev libzstd-dev lighttpd locales ninja-build \
  ocl-icd-opencl-dev opencl-headers pandoc pdal pkg-config poppler-utils \
  protobuf-compiler pyqt5-dev pyqt5-dev-tools pyqt5.qsci-dev python3-all-dev \
  python3-autopep8 python3-dateutil python3-dev python3-future python3-gdal \
  python3-httplib2 python3-jinja2 python3-lxml python3-markupsafe python3-mock \
  python3-nose2 python3-owslib python3-plotly python3-psycopg2 python3-pygments \
  python3-pyproj python3-pyqt5 python3-pyqt5.qsci python3-pyqt5.qtpositioning \
  python3-pyqt5.qtsql python3-pyqt5.qtsvg python3-pyqt5.qtwebkit python3-requests \
  python3-sip python3-sip-dev python3-six python3-termcolor python3-tz python3-yaml \
  qt3d-assimpsceneimport-plugin qt3d-defaultgeometryloader-plugin \
  qt3d-gltfsceneio-plugin qt3d-scene2d-plugin qt3d5-dev qt5-default qt5keychain-dev \
  qtbase5-dev qtbase5-private-dev qtpositioning5-dev qttools5-dev qttools5-dev-tools \
  saga spawn-fcgi xauth xfonts-100dpi xfonts-75dpi xfonts-base \
  xfonts-scalable xvfb -y

sed -i '$ a export PATH=/usr/lib/ccache:$PATH' "${HOME}"/.bashrc

source "${HOME}"/.bashrc

#mkdir -p /home/dev/cpp

cd /home/dev/cpp || exit 1

# git clone git://github.com/qgis/QGIS.git

cd QGIS || exit 1

git checkout final-3_22_0

mkdir build-master

cd build-master || exit 1

# taken from FORCE Makefile
mkdir temp-bin

# I thought it would install into this directory, but it doesn't. Instead, the folder
# output is created
cmake -G Ninja -D CMAKE_INSTALL_PREFIX=home/dev/cpp/QGIS/build-master/temp-bin ..

# is this the only target I need?
ninja qgis_process

# taken from FORCE Makefile
chmod 0755 home/dev/cpp/QGIS/build-master/output/bin/qgis_process
# wieso der Punkt? Bedeutet einfach: dieses directory, aber keine Unterordner?
cp home/dev/cpp/QGIS/build-master/output/bin/qgis_process /usr/local/bin/

# Clean happens at the end of Dockerfile

