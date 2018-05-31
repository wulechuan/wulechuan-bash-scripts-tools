___virtualMachineHost='123.45.67.89'

deploy-by-s-copying  'linux-in-vmware-wulechuan'  "wulechuan@$___virtualMachineHost"  
deploy-by-s-copying  'linux-in-vmware-wulechuan'       "root@$___virtualMachineHost"

unset ___virtualMachineHost