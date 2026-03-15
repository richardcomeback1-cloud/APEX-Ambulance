Config = Config or {}

-- ตั้งค่าไอเท็มที่ต้องใช้กับการกระทำของหมอ
Config.RequiredMedicItems = {
    revive = {
        name = 'ag_medikit',
        label = 'Medikit'
    },
    heal = {
        name = 'ag_medikit',
        label = 'Medikit'
    }
}

-- ตั้งค่าไอเท็มในร้าน Pharmacy
Config.PharmacyItems = {
    { label = 'First Aid Kit', item = 'ag_medikit', count = 1 },
    { label = 'Oxygen Mask', item = 'ag_scuba', count = 1 }
}
