var Config = new Object();
var sum = 0;
Config.closeKeys = [38, 27];

window.addEventListener('message', function (event) {
	var event = event.data;

	if (event.message == "openNUI") {
        sum = 0;
        if (event.display == "true") {
            $(".assist_container").fadeIn()
            $(".BillName").html(event.name) 
        } else {
            $(".assist_container").fadeOut()
        }
	}else if (event.message == "updateBalance") {
       // const myElement = document.getElementsByClassName("Cash");
       // console.log(myElement[0].innerHTML);
        if (event.Money < 0){ 
            $("#Cash").html("-"+formatMoney(Math.abs(event.Money)))
        } else {
            $("#Cash").html(formatMoney(event.Money))  
        }

        if (event.balance < 0){
            $("#Bank").html("-"+formatMoney(Math.abs(event.balance)))
        } else {
            $("#Bank").html(formatMoney(event.balance)) 
        } 

    }else if (event.message == "Billalllist") {
        $(".PriceBill").html(""); 
        $(".Borad").html("");
            $.each(event.listBilling, function (index, item) {
                var Pay = "";
                sum = sum + item.amount

                    if (event.limit <= sum) {
                        $(".PriceLimit").fadeIn()
                        $(".PriceLimit").html("ยอดเงินเกิน " + (formatMoney(event.limit)) + " ที่กำหนด")
                    } else {
                        $(".PriceLimit").fadeOut()
                    }   
                    if (item.amount <= 0){
                        $(".PriceBill").html("-");
                        $(".PriceBill").html(0);
                    } else {
                        if (item.amount >= 1000) {
                            // Pay = String((item.amount / 1000).toFixed(0)) + "K";
                            Pay = String((item.amount / 1000)) + "K";
                        } else {
                            Pay = String(item.amount)
                        }
                        var apps = `
                        <div class="Listbill">
                            <div class="Number">`+ (index+1) +`
                                <div class="labal">`+ (item.label) +`</div>
                            </div>
                            <div class="Pricebillin">`+ (Pay) +`
                            <button class="btn" onclick="Paybill('`+item.id+`')"><ion-icon name="wallet-outline"></ion-icon></button>
                            </div>
                        </div>
                            `;
                        $(".Borad").append(apps);
                    }
            });
        $(".PriceBill").html(formatMoney(sum));
    }
});

$("body").on("keyup", function (key) {
	if (Config.closeKeys.includes(key.which)) {
    $.post(`https://${GetParentResourceName()}/quit`, JSON.stringify({}));
	}
});

function Paybill(id){  // ฟังก์ชันสำหรับแปลงค่าตัวเลขให้อยู่ในรูปแบบ เงิน
    $.post(`https://${GetParentResourceName()}/Paybill`, JSON.stringify({
        idbill: id,
    }));
}

function formatMoney(inum){  // ฟังก์ชันสำหรับแปลงค่าตัวเลขให้อยู่ในรูปแบบ เงิน
    var s_inum=new String(inum);
    var num2=s_inum.split(".");
    var n_inum="";  
    if(num2[0]!=undefined){
        var l_inum=num2[0].length;  
        for(i=0;i<l_inum;i++){  
            if(parseInt(l_inum-i)%3==0){  
                if(i==0){  
                    n_inum+=s_inum.charAt(i);         
                }else{  
                    n_inum+=","+s_inum.charAt(i);         
                }     
            }else{  
                n_inum+=s_inum.charAt(i);  
            }  
        }  
    }else{
        n_inum=inum;
    }
    if(num2[1]!=undefined){
        n_inum+="."+num2[1];
    }
    return n_inum;
}