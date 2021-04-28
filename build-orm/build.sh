#!/bin/sh

out_file="orm.zip"

echo "Cleaning up...."
rm -rvf ./tmp_package
rm -vf ${out_file}

# set after cleanup, since failure of that rm is ok
set -euo

echo "Creating tmp dir...."
mkdir ./tmp_package

echo "Copying .tf files to tmp dir...."
cp -v ../*.tf ./tmp_package
echo "Copying schema.yaml to tmp dir...."
cp -v ../*.yaml ./tmp_package
echo "Copying script directory to tmp dir...."
cp -rv ../scripts ./tmp_package

echo "Removing provider.tf...."
rm ./tmp_package/provider.tf

echo "Creating $out_file ...."
cd tmp_package
zip -r ${out_file} *
cd ..
mv tmp_package/${out_file} ./
