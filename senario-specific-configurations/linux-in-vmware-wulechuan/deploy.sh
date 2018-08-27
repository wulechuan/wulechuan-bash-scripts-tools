___virtualMachineHost1='192.168.12.34'

deploy-by-s-copying  'linux-in-vmware-wulechuan'  "wulechuan@$___virtualMachineHost1"  
deploy-by-s-copying  'linux-in-vmware-wulechuan'       "root@$___virtualMachineHost1"

unset ___virtualMachineHost1