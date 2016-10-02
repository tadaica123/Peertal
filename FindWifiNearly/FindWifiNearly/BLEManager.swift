//
//  BLEObjectData.swift
//  FindWifiNearly
//
//  Created by Leon Trần on 5/5/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import CoreBluetooth
import Foundation


protocol BLEBandManagerDelegate: NSObjectProtocol {
    func recievedDeviceList(_ arrayDevice:[BLEManager.BluetoothPeripheral])
}

class BLEManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {

    struct BluetoothPeripheral {
        let name: String
        let UUID: String
        let RSSI: String
        let peripheral: CBPeripheral
        
        init(name: String, UUID: String, RSSI: NSNumber, peripheral: CBPeripheral) {
            self.name = "\(name)"
            self.UUID = "\(UUID)"
            self.RSSI = "\(RSSI)"
            self.peripheral = peripheral
        }
    }
    
    var scanning:Bool = false
    let DEVICE_NAME:String! = "TEST"
    var peripheralArray: [BluetoothPeripheral] = []
    var selectedPeripheral: BluetoothPeripheral?
    var characteristicArray: [CBCharacteristic] = []
    var CBmanager: CBCentralManager = CBCentralManager()
    var measurementValue: [[AnyObject?]] = [[]]
    var delegate:BLEBandManagerDelegate!

    //Basic functions
    override init() {
        super.init()
        CBmanager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func connectPeripheral(_ selectedPeripheral: BluetoothPeripheral) {
        CBmanager.connect(selectedPeripheral.peripheral, options: nil)
    }
    
    func setDelegateBand (_ delegate:BLEBandManagerDelegate){
        self.delegate = delegate
    }
    
    func waitRecieveDevice (){
        if ((self.delegate) != nil ) {
            self.delegate.recievedDeviceList(peripheralArray)
        }
    }
    
    func disconnectPeripheral(_ selectedPeripheral: BluetoothPeripheral) {
        for characteristic in characteristicArray {
            selectedPeripheral.peripheral.setNotifyValue(false, for: characteristic as CBCharacteristic)
        }
        CBmanager.cancelPeripheralConnection(selectedPeripheral.peripheral)
    }
    
    func ScanForPeripherals() {
        scanning = true
        CBmanager.scanForPeripherals(withServices: nil, options: nil)
        print("Scanning")
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch(central.state) {
        case .poweredOn:
            break
        case .poweredOff:
            peripheralArray.removeAll()
            print("NO BLE!")
        case .resetting, .unauthorized, .unsupported, .unknown:
            peripheralArray.removeAll()
             print("NO BLE!")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if scanning{
            let triggerTime = (Int64(NSEC_PER_SEC) * 10)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
                self.scanning = false
                self.waitRecieveDevice()
            })
        }

//        let UUID1 = "\(peripheral.identifier)".substringFromIndex("\(peripheral.identifier)".startIndex.advancedBy(31))
        let UUID = peripheral.identifier.uuidString
        if peripheral.name != nil {
            var check: Int = 1
            for i in 0  ..< peripheralArray.count {
                if peripheralArray[i].UUID == UUID {
                    check = 0
                    break
                }
            }
            if check == 1 {
                 peripheralArray.append(BluetoothPeripheral(name: peripheral.name!, UUID: UUID, RSSI: RSSI, peripheral: peripheral))
            }
        } else {
            var check: Int = 1
            for i in 0  ..< peripheralArray.count {
                if peripheralArray[i].UUID == UUID {
                    check = 0
                    break
                }
            }
            if check == 1 {
                peripheralArray.append(BluetoothPeripheral(name: "Unknow Device", UUID: UUID, RSSI: RSSI, peripheral: peripheral))
            }

        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected")
        measurementValue.removeAll()
        peripheral.delegate = self
        selectedPeripheral!.peripheral.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Fail")
    }
    
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        print("Restore")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services! {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic in service.characteristics as [CBCharacteristic]!{
            if characteristic.properties.contains(CBCharacteristicProperties.notify) {
                peripheral.discoverDescriptors(for: characteristic)
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if characteristic.isNotifying {
            characteristicArray.append(characteristic as CBCharacteristic)
            peripheral.readValue(for: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        //Store new characteristic values
    }

}


