$(function () {

    var alert = new Audio('alert.mp3');
    alert.volume = 0.1;

    let notiid = 0
    let maxnoti = 2
    let deletenoti = 0

    window.addEventListener('message', function(event) {
        var item = event.data;

        ///////////////////////////////////////////////////////// Notify

        if (item.type == "changeposition") {
            $(".notify").css({"right": ""+item.right+"%"});
            $(".alertmain").css({"right": ""+item.right+"%"});
        }

        if (item.type == "togglenotify") {
            // let color = "rgb(255, 0, 54)"
            // if (item.notify.type) {
            //     if (item.notify.type == "success") {
            //         color = "rgb(120, 171, 190)"
            //     }
            //     if (item.notify.type == "error") {
            //         color = "rgb(255, 255, 255, 0.6)"
            //     }
            //     if (item.notify.type == "warning") {
            //         color = "rgb(255, 185, 20)"
            //     }
            // }
            // $(".notify").append(`
            //     <div class="notifytoggle ${notiid}" id="${item.notify.id}" style="border-left: 2px solid ${color};">
            //         <div class="notitext">${item.notify.text}</div>
            //         <div class="borderloadtime" id="loadid_${item.notify.id}" style="width: 100%; transition: ${item.notify.time}ms; background-color: ${color}; box-shadow: 0px 0px 5px ${color};"></div>
            //     </div>
            // `);
            // $("#"+item.notify.id+"").show();

            // notiid = notiid + 1
            // if (notiid > maxnoti) {
            //     $("."+deletenoti+"").remove();
            //     deletenoti = deletenoti + 1
            // }

            // setTimeout(function() {
            //     $("#"+item.notify.id+"").css({"transform": "translateX(0%)","opacity": "100%"});

            //     $("#loadid_"+item.notify.id+"").css({"width": "0%", "transition": ""+item.notify.time+"ms"});

            //     setTimeout(function() {
                    
            //         $("#"+item.notify.id+"").css({"transform": "translateX(120%)","opacity": "0%"});
            //         setTimeout(function() {
            //             $("#"+item.notify.id+"").remove();
            //         }, 350);
            //     }, item.notify.time);

            // }, 100);
            let color = "rgb(42, 63, 18, 0.8)"
            if (item.notify.type) {
                if (item.notify.type == "success") {
                    $(".notify").append(`
                        <div class="notifytoggle ${notiid}" id="${item.notify.id}">
                            <img src="img/success.png" class="notibox">
                            <div class="notitext">${item.notify.text}</div>
                        </div>
                    `);
                }
                if (item.notify.type == "error") {
                    $(".notify").append(`
                        <div class="notifytoggle ${notiid}" id="${item.notify.id}">
                            <img src="img/error2.png" class="notibox">
                            <div class="notitext">${item.notify.text}</div>
                        </div>
                    `);
                }
                if (item.notify.type == "warning") {
                    $(".notify").append(`
                        <div class="notifytoggle ${notiid}" id="${item.notify.id}">
                            <img src="img/warning.png" class="notibox">
                            <div class="notitext">${item.notify.text}</div>
                        </div>
                    `);
                }
            }
            
            $("#"+item.notify.id+"").show();

            notiid = notiid + 1
            if (notiid > maxnoti) {
                $("."+deletenoti+"").remove();
                deletenoti = deletenoti + 1
            }

            setTimeout(function() {
                $("#"+item.notify.id+"").css({"transform": "translateX(0%)","opacity": "100%"});

                setTimeout(function() {
                    $("#"+item.notify.id+"").css({"transform": "translateX(120%)","opacity": "0%"});
                    setTimeout(function() {
                        $("#"+item.notify.id+"").remove();
                    }, 350);
                }, item.notify.time);

            }, 100);
        }

        ///////////////////////////////////////////////////////// Notify

        ///////////////////////////////////////////////////////// Alert

        if (item.type == "add") {
            if (item.data) {
                // let wpbtn = ""
                // let icon = ""
                // if (item.data.wp_key) {
                //     wpbtn = `<div style='display:flex;height:45%;padding-right:1svh;column-gap:0.2svh'>
                //     <span class="kb-btn">SHIFT</span>
                //     <span style='font-size:1.8svh;margin-right: 0.3svh'>+</span>
                //     <span class="kb-btn">${item.data.wp_key}</span>
                //     </div><br>`
                    // wpbtn = `<span>SHIFT</span><span>${item.data.wp_key}</span><br>`
                // }
                // $(".alertlist").append(`
                //     <div class="alert" id="${item.data.index}">
                //     <div class="icon"><img src="img/${item.data.icon}.png"></div>
                //         <div class="text">${item.data.text} <img src="img/location.png">${item.data.zone}${wpbtn} <div class="timebar" id="bar${item.data.index}"></div> </div>
                //     </div>
                // `);
                // $(".alertlist").append(`
                //     <div class="alert ${item.data.icon+'-top'}" id="${item.data.index}" style="transform: translateX(0%); opacity: 1;">
                //     <div class="icon ${item.data.icon}"><span style="font-size: 2.6svh;">${item.data.wp_key}</span></div>
                //     <div class="text">
                //         <div class="case">
                //             <span class="case-name">${item.data.text}</span>
                //             <div class="location-area">
                //                 <div class="location-txt">Location : </div>
                //                 <div class="location-value">${item.data.zone}</div>
                //             </div>
                //         </div>
                //         ${wpbtn}
                //         <div class="timebar" id="bar${item.data.index}"></div>
                //     </div>
                // </div>
                // `);
                $(".alertlist").append(`
                    <div class="alert" id="${item.data.index}">
                        <div class="icon">
                            <span>${item.data.wp_key}</span>
                        </div>
                        <div class="control-btn"><div class="shift">SHIFT</div>+<div class="num-alert">${item.data.wp_key}</div></div>
                        <div class="infor-alert">
                            <span style="font-size: 12px;">${item.data.text}</span>
                            <span>LOCATION : ${item.data.zone}</span>
                        </div>
                        <div class="bg-bar">
                            <div class="load-bar">
                                <div class="timebar" id="bar${item.data.index}"></div>
                            </div>
                        </div>
                    </div>
                `);
                setTimeout(function() {
                    $("#"+item.data.index+"").css({
                        "transform": "translateX(0%)",
                        "opacity": "100%",
                    });
                    alert.play();
                    $( "#bar"+item.data.index+"" ).animate({
                        width: "0%",
                    }, item.data.time*1000, function() {
                    
                    });
                }, 100);
            }
        }
        if (item.type == "remove") {
            $("#"+item.id+"").css({
                "transform": "translateX(110%)",
                "opacity": "0%",
            });
            setTimeout(function() {
                $("#"+item.id+"").remove();
            }, 100);
        }
        ///////////////////////////////////////////////////////// Alert

        ///////////////////////////////////////////////////////// iTemsnotify
        if (item.type == "itemsnotify") {
            let color = `rgb(${item.color.R}, ${item.color.G}, ${item.color.B})`
            let Text = item.text
            $(".itemsnotify").append(`
                <div class="itemnotify" id="${item.id}">
                    <div class="bar" style="background-color:${color};box-shadow: 0px 0px 10px ${color};"></div>
                    <div class="bar" style="background-color:${color};box-shadow: 0px 0px 10px ${color};"></div>
                    <div class="itemimg"><img src="${item.inventoryLink}${item.name}.png"></div>
                    <div class="typename"><span>${item.label}</span></div>
                    <div class="amount"><span>${item.count}</span>${item.ea}</div>
                    <div class="showtype" style="background-color: ${color}; box-shadow: 0px 0px 5px ${color};"><span>${Text[item.action]}</span></div>
                </div>
            `);
            $("img").on("error", function () {
                $(this).attr("src", "error.png");
            });
            setTimeout(function() {
                $("#"+item.id+"").css({
                    "transform": "translateX(0%)",
                    "opacity": "100%",
                });
            }, 10);
            setTimeout(function() {
                $("#"+item.id+"").css({
                    "transform": "translateX(110%)",
                    "opacity": "0%",
                });
                setTimeout(function() {
                    $("#"+item.id+"").hide();
                    setTimeout(function() {
                        $("#"+item.id+"").remove();
                    }, 1000);
                }, 200);
            }, item.time);
        }
        ///////////////////////////////////////////////////////// iTemsnotify
    })

})