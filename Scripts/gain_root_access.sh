echo
echo "======================================================================"
echo "======                   Gain root privileges                   ======"
echo "======================================================================"
echo

if [ "$1" == "" ]; then
    cat <<USAGE
Syntax: $0 <iOS version>
USAGE
    exit 1
fi

if [ "$1" == "9" ]
then
    DEVICE_IP=192.168.14.81
elif [ "$1" == "10" ]
then
    DEVICE_IP=192.168.11.66
else
    echo "Unexpected iOS version: $1. Should be 9 or 10."
    exit 1
fi

echo "Device  : $DEVICE_IP"

if [ "$2" == "" ]; then
    cat <<USAGE
Syntax: $0 <iOS version> <iOS installed app uid>
No iOS installed app id defined.
USAGE
    exit 1
fi

APP_UID=$2
echo "App UID : $APP_UID"

APP_NAME=AppManager
echo "App name: $APP_NAME"

APP_PATH=/private/var/containers/Bundle/Application/$APP_UID/$APP_NAME.app
echo "App path: $APP_PATH"

BINARY_NEW_NAME="$APP_NAME"Exec
SCRIPT_NAME=$APP_NAME".sh"
echo "Script  : $SCRIPT_NAME"

if [ ! -r "./$SCRIPT_NAME" ]; then
    echo "'$SCRIPT_NAME' not found or not readable"
    exit 1
fi

echo
echo "Starting..."
echo

echo "Action on device: Renaming the binary ($APP_NAME -> $BINARY_NEW_NAME)..."
#ssh root@$IPHONE_IP "mv $APP_PATH/$APP_NAME $APP_PATH/$BINARY_NEW_NAME"

echo "Action on device: Setting ownership of the binary ($BINARY_NEW_NAME) to 'root:wheel'..."
#ssh root@$IPHONE_IP "chown root:wheel $APP_PATH/$BINARY_NEW_NAME"

echo "Action on device: Setting user ID and group ID to the binary ($BINARY_NEW_NAME)..."
#ssh root@$IPHONE_IP "chmod 6755 $APP_PATH/$BINARY_NEW_NAME"

echo "Copying the script ($SCRIPT_NAME) to the device..."
# echo To skip entering SSH password each time use the following command:
# echo "ssh-copy-id root@$IPHONE_IP"

#scp ./build/$APP_NAME root@$IPHONE_IP:/usr/bin/$APP_NAME
#ssh root@$IPHONE_IP "cat > $APP_PATH/$APP_NAME" < "./$SCRIPT_NAME"
scp ./$SCRIPT_NAME root@$IPHONE_IP:$APP_PATH/$APP_NAME

echo "Action on device: Setting ownership of the script ($APP_NAME) to 'root:wheel'..."
#ssh root@$IPHONE_IP "chown root:wheel $APP_PATH/$APP_NAME"

echo "Action on device: Setting executable permissions to the script ($APP_NAME)..."
#ssh root@$IPHONE_IP "chmod 755 $APP_PATH/$APP_NAME"

echo
echo "Done!"
