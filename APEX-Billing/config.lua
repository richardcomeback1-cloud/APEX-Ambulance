Config = {}
Config.Locale = 'en'				

Config.MoneyBillpay = {									--- หัวข้อเงินห้ามเกินที่กำหนด
	enable = false,
	limit  = 500000,	
}		

Config.Billpayauto = {									--- หัวข้อบิลออโต้
	enable = true,										--- เปิด-ปิด ให้ทำการจ่ายออโต้ไหม
	timer = 10,										--- ตั้งเวลาในการจ่ายออโต้ (นาที)
	pNotify = true,									--- เปิด-ปิด แจ้งผู้เล่นไหม
}

Config.SendBill = {										---หัวข้อออโต้บิล
	enable = true,
	trigger = 'azael_dc-serverlogs:sendToDiscord',
	type = "SendBill",
}

Config.PayBill = {
	enable = true,
	trigger = 'azael_dc-serverlogs:sendToDiscord',		--- หัวข้อจ่ายบิล
	type = "PayBill",
}

Config.BillCut = { 										--- หัวข้อหักเปอร์เซ็นหน่วยงาน	
	society_ambulance = 30,
	society_police = 20,
	society_council = 100,
}
