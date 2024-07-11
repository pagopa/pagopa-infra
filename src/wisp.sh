

echo "Start >>>>>>>>>>>>>"
date

# >>> 1.shared-common
cd domains/shared-common/
echo ">>> shared-common sh terraform.sh summ weu-$1"
sh terraform.sh summ weu-$1

while true; do
    read -p "Do you wish to continue with apply ? " yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo ">>> shared-common sh terraform.sh apply weu-$1"
# yes yes | sh terraform.sh apply weu-$1
sh terraform.sh apply weu-$1

# >>> 2.nodo-app
cd ../nodo-app
echo ">>> nodo-app sh terraform.sh summ weu-$1"
sh terraform.sh summ weu-$1

while true; do
    read -p "Do you wish to continue with apply ? " yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo ">>> nodo-app sh terraform.sh apply weu-$1"
# yes yes | sh terraform.sh apply weu-$1
sh terraform.sh apply weu-$1

# >>> 2.gps-app
cd ../gps-app
echo ">>> gps-app sh terraform.sh summ weu-$1"
sh terraform.sh summ weu-$1

while true; do
    read -p "Do you wish to continue with apply ? " yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo ">>> gps-app sh terraform.sh apply weu-$1"
# yes yes | sh terraform.sh apply weu-$1
sh terraform.sh apply weu-$1

# >>> 4.core
cd ../../core
echo ">>> core: sh terraform.sh summ $1"
sh terraform.sh summ $1

while true; do
    read -p "Do you wish to continue with apply ? " yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo ">>> core sh terraform.sh apply $1"
# yes yes | sh terraform.sh apply $1
sh terraform.sh apply $1

echo "END >>>>>>>>>>>>>"
date

