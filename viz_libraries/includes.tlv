\m4_TLV_version 1d: tl-x.org

\TLV zedboard_init(|_pipe, @_stage)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         \viz_alpha
            initEach() {
                  let block_square = new fabric.Rect(
                     {originX: "center",
                      originY: "center",
                      width: 490,
                      height: 300,
                      fill: "white"
                     }
                  )
                  let logic_block = new fabric.Group([block_square],
                  {originX: "center",
                   originY: "center",
                   angle: 0,
                   width: 20,
                   height: 20
                  })
                  let fpga_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/Zedboard.png?raw=true"
                  let fpga_img = new fabric.Image.fromURL(
                        fpga_img_url,
                        function (img) {
                           logic_block.add(img)
                           global.canvas.renderAll()
                           global.canvas.sendToBack(logic_block);
                        },
                        {originX: "center",
                         originY: "center",
                         left: 0,
                         top: 10,
                         scaleX: 0.3,
                         scaleY: 0.3,
                         angle: 0
                        }
                     )
                   let start_led = new fabric.Rect({
                        top: 200,
                        left: -195,
                        width: 5,
                        height: 8,
                        fill: "red",
                        opacity: 1
                     })
                return {objects :{logic_block}};
                }
         '],
         ['
         ']
         )
         
\TLV zedboard_led(|_pipe, @_stage, $leds)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         //$viz_leds[15:0] = {$L1,$P1,$N3,$P3,$U3,$W3,$V3,$V13,$V14,$U14,$U15,$W18,$V19,$U19,$E19,$U16};
         /led[7:0]
            \viz_alpha
               initEach() {
                  let led = new fabric.Rect({
                        top: 233,
                        left: 151 - 32 * (this.getIndex() + 1),
                        width: 6, 
                        height: 11, 
                        fill: "red",
                        opacity: 0
                     })
                  /*let done_led = new fabric.Rect({
                        top: -108,
                        left: 191, 
                        width: 5, 
                        height: 8, 
                        fill: "green",
                        opacity: 1
                     }) */
                  return{objects : {led /*, done_led*/}}; 
               }, 
               renderEach() {
                     var mod = ((('/top|_pipe$leds'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
                     console.log('/top|_pipe$leds'.asInt(-1))
                     this.getInitObject("led").set(mod ? {opacity: 1} : {opacity: 0});
                  }   
         '],
         ['
         ']
         )
         
\TLV artix7_init(|_pipe, @_stage)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         \viz_alpha
            initEach() {
                  let block_square = new fabric.Rect(
                     {originX: "center",
                      originY: "center",
                      width: 490,
                      height: 300,
                      fill: "white"
                     }
                  )
                  let logic_block = new fabric.Group([block_square],
                  {originX: "center",
                   originY: "center",
                   angle: 0,
                   width: 20,
                   height: 20
                  })
                  let fpga_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/artix7.png?raw=true"
                  let fpga_img = new fabric.Image.fromURL(
                        fpga_img_url,
                        function (img) {
                           logic_block.add(img)
                           global.canvas.renderAll()
                           global.canvas.sendToBack(logic_block);
                        },
                        {originX: "center",
                         originY: "center",
                         left: 0,
                         top: 10,
                         scaleX: 0.18,
                         scaleY: 0.18,
                         angle: 0
                        }
                     )
                   let start_led = new fabric.Rect({
                        top: 200,
                        left: -195,
                        width: 5,
                        height: 8,
                        fill: "red",
                        opacity: 1
                     })
                  let seg = new fabric.Rect({
                     top: 60,
                     left: -244,
                     width: 140, 
                     height: 60, 
                     fill: "black",
                     opacity: 1
                  })
                return {objects :{logic_block, seg}};
                
                }
         /digit[3:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: 109,
                           left: (scopes.digit.index == 3) ? -122 : (scopes.digit.index == 0) ? -212 : (scopes.digit.index == 1) ? -182 : -152 ,
                           radius: 2,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: 76 + ((scopes.led.index == 1) ? -4 : (scopes.led.index == 2) ? 16 : (scopes.led.index == 3) ? 31 : (scopes.led.index == 4) ? 16 : (scopes.led.index == 5) ? -4 : (scopes.led.index == 6) ? 11 : -8),
                           left: ((scopes.digit.index == 0) ? -224 : (scopes.digit.index == 1) ? -194 : (scopes.digit.index == 2) ? -164 : -134) + ((scopes.led.index == 5) ? 13 : (scopes.led.index == 4) ? 11 : (scopes.led.index == 3) ? -2 : (scopes.led.index == 2) ? -8 : (scopes.led.index == 1) ? -6 : -1),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 14 : 3,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 14 : 3,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg}};
                  }
         '],
         ['
         ']
         )
         
\TLV artix7_led(|_pipe, @_stage, $leds)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         //$viz_leds[15:0] = {$L1,$P1,$N3,$P3,$U3,$W3,$V3,$V13,$V14,$U14,$U15,$W18,$V19,$U19,$E19,$U16};
         /led[15:0]
            \viz_alpha
               initEach() {
                  let led = new fabric.Rect({
                        top: 150,
                        left: 218 - 27.5 * (this.getIndex() + 1),
                        width: 12, 
                        height: 12, 
                        fill: "red",
                        opacity: 0
                     })
                  /*let done_led = new fabric.Rect({
                        top: -108,
                        left: 191, 
                        width: 5, 
                        height: 8, 
                        fill: "green",
                        opacity: 1
                     }) */
                  return{objects : {led /*, done_led*/}}; 
               }, 
               renderEach() {
                     var mod = ((('/top|_pipe$leds'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
                     console.log('/top|_pipe$leds'.asInt(-1))
                     this.getInitObject("led").set(mod ? {opacity: 1} : {opacity: 0});
                  }   
         '],
         ['
         ']
         )
\TLV artix7_sseg(|_pipe, @_stage, $_digit, $_sseg, $_dp)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         
         /digit[3:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: 109,
                           left: (scopes.digit.index == 0) ? -122 : (scopes.digit.index == 3) ? -212 : (scopes.digit.index == 2) ? -182 : -152 ,
                           radius: 2,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: 76 + ((scopes.led.index == 5) ? -4 : (scopes.led.index == 4) ? 16 : (scopes.led.index == 3) ? 31 : (scopes.led.index == 2) ? 16 : (scopes.led.index == 1) ? -4 : (scopes.led.index == 0) ? 11 : -8),
                           left: ((scopes.digit.index == 3) ? -224 : (scopes.digit.index == 2) ? -194 : (scopes.digit.index == 1) ? -164 : -134) + ((scopes.led.index == 5) ? 13 : (scopes.led.index == 4) ? 11 : (scopes.led.index == 3) ? -2 : (scopes.led.index == 2) ? -8 : (scopes.led.index == 1) ? -6 : -1),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 14 : 3,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 14 : 3,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg}};
                  },
                  renderEach() {
                     var enable = ('/top|_pipe$_digit'.asBinaryStr().split("").reverse().join(""));
                     this.getInitObject("sseg").bringToFront()
                     var sseg1 = ('/top|_pipe$_sseg'.asBinaryStr());
                     var fp_valid = '/top|_pipe$_dp'.asBool() == 1
                     if(scopes.led.index == 7)
                     {
                        console.log("scopes.digit.index:", scopes.digit.index)
                        this.getInitObject("sseg").set(enable[scopes.digit.index] == 1 && fp_valid ? {fill: "red"} : {fill: "grey"})
                     }
                     else {
                        var hamm = ((('/top|_pipe$_sseg'.asInt(-1) >> scopes.led.index) & 1) == 0);
                        this.getInitObject("sseg").set(hamm && enable[scopes.digit.index] == 1 ? {fill: "red"} : {fill: "grey"});
                     }
                  }
          
         '],
         ['
         ']
         )
\TLV artix7_lcd(|_pipe, @_stage, $out, $lcd_enable, $lcd_reset)
   //for viz part
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         // VIZ supports only 8 bit mode (4 bit mode not supported)
         $one_or_two[1:0] = $reset ? 0 : $out == 8'h38 ? 2 : $out == 8'h30 ? 1 : >>1$one_or_two;    // 1-line mode or 2-line mode
         $line[1:0] = $reset ? 0 : $lcd_reset == 0 ? ($out == 8'h80 | $out == 8'h01 |$out == 8'h02) & !$one_or_two == 0 ? 1 : 
                      $out == 8'hC0 & $one_or_two == 2 ? 2 :
                      $RETAIN: 
                      $RETAIN;    // assign line number
         $inc_or_dec[1:0] = $reset ? 0 : $out == 8'h06 ? 1 : 
                            $out == 8'h04 ? 2 : 
                            >>1$inc_or_dec;    // increment or decrement cursor command
         $read_enable = $lcd_enable == 1 && >>1$lcd_enable == 0;
         $shift_left[5:0] = $reset | >>1$shift_left == 40 ? 0 : 
                            ($out == 8'h18 & !$lcd_reset & $read_enable ? >>1$shift_left + 1 : 
                            $RETAIN);          // no of shift lefts
         $shift_right[5:0] = $reset | >>1$shift_right == 40 ? 0 : 
                             ($out == 8'h1C & $lcd_reset == 0 & $read_enable ? >>1$shift_right + 1 : 
                             $RETAIN);         // no of shift rights
         $wr_index1[6:0] = (($reset | $out == 8'h01 | $out == 8'h80) & $lcd_reset == 0) ? 0 : 
                             $read_enable && $line == 1 && $lcd_reset == 0 ? ($out == 8'h14 ? >>1$wr_index1 + 1 : 
                            ($out == 8'h10 ? >>1$wr_index1 - 1 : $RETAIN)) : 
                             $read_enable && $line == 1 && $lcd_reset == 1 ? ($inc_or_dec == 1 ? >>1$wr_index1 + 1 : 
                             $inc_or_dec == 2 ? >>1$wr_index1 - 1 : >>1$wr_index1) : 
                             >>1$wr_index1;    // cursor index if line 1
         $wr_index2[5:0] = (($reset | $out == 8'h01 | $out == 8'hC0) & $lcd_reset == 0) ? 0 : 
                             $read_enable && $line == 2 && $lcd_reset == 0 ? ($out == 8'h14 ? >>1$wr_index2 + 1 : 
                            ($out == 8'h10 ? >>1$wr_index2 - 1 : $RETAIN)) : 
                             $read_enable && $line == 2 && $lcd_reset == 1 ? ($inc_or_dec == 1 ? >>1$wr_index2 + 1 : 
                             $inc_or_dec == 2 ? >>1$wr_index2 - 1 : >>1$wr_index2) : 
                             >>1$wr_index2;    // cursor index if line 2
         /chars1[40-1:0]
            $char1[7:0] = |_pipe$out == 8'h01 & |_pipe$lcd_reset == 0 ? 8'h20 : 
                          |_pipe>>1$wr_index1 == #chars1 && |_pipe$line == 1 && |_pipe$read_enable && |_pipe$lcd_reset == 1 ? |_pipe$out : 
                          $RETAIN;
         /chars2[40-1:0]
            $char2[7:0] = |_pipe$out == 8'h01 & |_pipe$lcd_reset == 0 ? 8'h20 : 
                          ((|_pipe>>1$wr_index2 == #chars2 && |_pipe$line == 2) | (|_pipe>>1$wr_index1 - 40 == #chars2 && |_pipe$line == 1)) && |_pipe$read_enable && |_pipe$lcd_reset == 1 ? |_pipe$out : 
                          $RETAIN;
         $str1[8*16-1:0] = (/chars1[*]$char1 >> 8*$shift_left) << 8*$shift_right;
         $str2[8*16-1:0] = (/chars2[*]$char2 >> 8*$shift_left) << 8*$shift_right;


         \viz_alpha
            initEach() {
                  let block_square = new fabric.Rect(
                     {originX: "center",
                      originY: "center",
                      fill : "transparent"
                     }
                  )
                  let logic_block = new fabric.Group([block_square],
                  {originX: "center",
                   originY: "center",
                  })
                  let lcd_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/lcd_module.png?raw=true"
                  let lcd_img = new fabric.Image.fromURL(
                        lcd_img_url,
                        function (img) {
                           logic_block.add(img)
                           global.canvas.renderAll()
                        },
                        {originX: "center",
                         originY: "center",
                         left: -35,
                         top: 320,
                         scaleX: 0.2,
                         scaleY: 0.2,
                         angle: 0.4
                        }
                     )
                   let start_led = new fabric.Rect({
                        top: -108,
                        left: -195,
                        width: 5,
                        height: 8,
                        fill: "red",
                        opacity: 1
                     })
                    let lcd = new fabric.Rect({
                        top: 280,
                        left: -165,
                        width: 295,
                        height: 80,
                        fill: "#FDFF32",
                        opacity: 1
                     })
                     let line1 = new fabric.Text("", {
                       left: -160,
                       top: 290,
                       fontSize: 30,
                       fontFamily: "Courier New",
                     })
                     let line2 = new fabric.Text("", {
                       left: -160,
                       top: 320,
                       fontSize: 30,
                       fontFamily: "Courier New",
                     })
                     let info = new fabric.Text("", {
                       left: -300,
                       top: -250,
                       fontSize: 15,
                       fontFamily: "Courier New",
                     })
                     let clock = new fabric.Text("Clock Frequency = 100Hz", {
                       left: 80,
                       top: -250,
                       fontSize: 15,
                       fontFamily: "Courier New",
                     })
                
                return {objects :{logic_block, lcd, line1, line2, info, clock}};
                },
             renderEach(){
                 let str1 = '/top|_pipe$str1'.asString().split("").reverse().join("")
                 let str2 = '/top|_pipe$str2'.asString().split("").reverse().join("")
                 let lcd_rst = '/top|_pipe$lcd_reset'.asBool()
                 this.getInitObjects().line1.setText(str1)
                 this.getInitObjects().line2.setText(str2)
                 let value_bin = '/top|_pipe$out'.asBinaryStr();
                 if(!lcd_rst){
                 if (value_bin == "00111000"){
                    //8'h38
                    //Function Set: 8-bit, 2 Line, 5x7 Dots
                    this.getInitObjects().info.setText("Function Set: 8-bit, 2 Line, 5x7 Dots")
                 }else if (value_bin == "00110000"){
                    //Function Set: 8-bit,  Line, 5x7 Dots
                    //8'h30
                    this.getInitObjects().info.setText("Function Set: 8-bit, 1 Line, 5x7 Dots")
                 }else if (value_bin == "00001100"){
                    //Display on Cursor off
                    //8'h0C
                    this.getInitObjects().info.setText("Display on Cursor off")
                 }else if (value_bin == "00000110"){
                    //Entry Mode
                    //8'h06
                    this.getInitObjects().info.setText("Entry Mode: Increment, entire shift off")
                 }else if (value_bin == "00000100"){
                    //Entry Mode
                    //8'h04
                    this.getInitObjects().info.setText("Entry Mode: Decrement, entire shift off")
                 }else if (value_bin == "00000001"){
                    //Clear Display
                    //8'h01
                    this.getInitObjects().info.setText("Clear Display")
                 }else if (value_bin == "00000010"){
                    //Return home
                    //8'h02
                    this.getInitObjects().info.setText("Return home")
                 }else if (value_bin == "10000000"){
                    //force cursor to begin at first line
                    //8'h80
                    this.getInitObjects().info.setText("force cursor to begin at first line")
                 }else if (value_bin == "11000000"){
                    //force cursor to begin at second line
                    //8'hC0
                    this.getInitObjects().info.setText("force cursor to begin at second line")
                 }else if (value_bin == "00011000"){
                    //Shift display left
                    //8'h18
                    this.getInitObjects().info.setText("Shift entire display to the left")
                 }else if (value_bin == "00011100"){
                    //Shift display right
                    //8'h1C
                    this.getInitObjects().info.setText("Shift entire display to the right")
                 }else if (value_bin == "00010000"){
                    //Shift cursor left 
                    //8'h10
                    this.getInitObjects().info.setText("Shift cursor to the left")
                 }else if (value_bin == "00010100"){
                    //Shift cursor right
                    //8'h14
                    this.getInitObjects().info.setText("Shift cursor to the right")
                 }
              }else {
                 this.getInitObjects().info.setText("data instruction")
              }
             }
          
         '],
         ['
         ']
         )
         
         
\TLV basys3_init(|_pipe, @_stage)
   |_pipe
      @_stage
         \viz_alpha
            initEach() {
                  let block_square = new fabric.Rect(
                     {originX: "center",
                      originY: "center",
                      width: 490,
                      height: 300,
                      fill: "white"
                     }
                  )
                  let logic_block = new fabric.Group([block_square],
                  {originX: "center",
                   originY: "center",
                   angle: 0,
                   width: 20,
                   height: 20
                  })
                  let fpga_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/basys3.png?raw=true"
                  let fpga_img = new fabric.Image.fromURL(
                        fpga_img_url,
                        function (img) {
                           logic_block.add(img)
                           global.canvas.renderAll()
                           global.canvas.sendToBack(logic_block);
                        },
                        {originX: "center",
                         originY: "center",
                         left: 0,
                         top: 10,
                         scaleX: 0.09,
                         scaleY: 0.09,
                         angle: 0
                        }
                     )
                   let start_led = new fabric.Rect({
                        top: 200,
                        left: -195,
                        width: 5,
                        height: 8,
                        fill: "red",
                        opacity: 1
                     })
                  let seg = new fabric.Rect({
                           top: 50,
                           left: -182,
                           width: 124, 
                           height: 39, 
                           fill: "black",
                           opacity: 1
                        })
                return {objects :{logic_block, seg}};
                }
         /digit[3:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: 79,
                           left: (scopes.digit.index == 0) ? -157 : (scopes.digit.index == 1) ? -127 : (scopes.digit.index == 2) ? -97 : -67 ,
                           radius: 2,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: 56 + ((scopes.led.index == 5) ? 1 : (scopes.led.index == 4) ? 13 : (scopes.led.index == 3) ? 23 : (scopes.led.index == 2) ? 13 : (scopes.led.index == 1) ? 1 : (scopes.led.index == 0) ? 11 : 0),
                           left: ((scopes.digit.index == 0) ? -169 : (scopes.digit.index == 1) ? -139 : (scopes.digit.index == 2) ? -109 : -79) + ((scopes.led.index == 5) ? 10 : (scopes.led.index == 4) ? 8 : (scopes.led.index == 3) ? -2 : (scopes.led.index == 2) ? -6 : (scopes.led.index == 1) ? -4 : 0),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 11 : 3,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 11 : 3,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg }};
                  }
         
\TLV basys3_led(|_pipe, @_stage, $leds)
   |_pipe
      @_stage
         //$viz_leds[15:0] = {$L1,$P1,$N3,$P3,$U3,$W3,$V3,$V13,$V14,$U14,$U15,$W18,$V19,$U19,$E19,$U16};
         /led[15:0]
            \viz_alpha
               initEach() {
               debugger
                  let led = new fabric.Rect({
                        top: 92,
                        left: 195 - 25 * (this.getIndex() + 1),
                        width: 6, 
                        height: 10, 
                        fill: "red",
                        opacity: 0
                     })
                  return{objects : {led}}; 
               }, 
               renderEach() {
                     var mod = ((('/top|_pipe$leds'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
                     this.getInitObject("led").set(mod ? {opacity: 1} : {opacity: 0});
                  }  
\TLV basys3_sseg(|_pipe, @_stage, $_digit, $_sseg, $_dp)
   |_pipe
      @_stage
         /digit[3:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: 79,
                           left: (scopes.digit.index == 3) ? -157 : (scopes.digit.index == 2) ? -127 : (scopes.digit.index == 1) ? -97 : -67 ,
                           radius: 2,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: 56 + ((scopes.led.index == 5) ? 1 : (scopes.led.index == 4) ? 13 : (scopes.led.index == 3) ? 23 : (scopes.led.index == 2) ? 13 : (scopes.led.index == 1) ? 1 : (scopes.led.index == 0) ? 11 : 0),
                           left: ((scopes.digit.index == 3) ? -169 : (scopes.digit.index == 2) ? -139 : (scopes.digit.index == 1) ? -109 : -79) + ((scopes.led.index == 5) ? 10 : (scopes.led.index == 4) ? 8 : (scopes.led.index == 3) ? -2 : (scopes.led.index == 2) ? -6 : (scopes.led.index == 1) ? -4 : 0),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 11 : 3,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 11 : 3,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg }};
                  },
                  renderEach() {
                     var enable = ('/top|_pipe$_digit'.asBinaryStr().split("").reverse().join(""));
                     var sseg1 = ('/top|_pipe$_sseg'.asBinaryStr());
                     this.getInitObject("sseg").bringToFront()
                     var fp_valid = '/top|_pipe$_dp'.asBool() == 0
                     if(scopes.led.index == 7)
                     {
                        console.log("scopes.digit.index:", scopes.digit.index)
                        this.getInitObject("sseg").set(enable[scopes.digit.index] == 0 && fp_valid ? {fill: "red"} : {fill: "grey"})
                     }
                     else {
                        var hamm = ((('/top|_pipe$_sseg'.asInt(-1) >> scopes.led.index) & 1) == 0);
                        this.getInitObject("sseg").set(hamm && enable[scopes.digit.index] == 0 ? {fill: "red"} : {fill: "grey"});
                     }
                  }


\TLV iceboard_init(|_pipe, @_stage)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         \viz_alpha
            initEach() {
                  let fpga_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/iceBreaker.png?raw=true"
                  let fpga_img = new fabric.Image.fromURL(
                        fpga_img_url,
                        function (img) {
                           global.canvas.add(img)
                           global.canvas.sendToBack(img);
                        },
                        {originX: "center",
                         originY: "center",
                         left: -100,
                         top: 10,
                         scaleX: 0.5,
                         scaleY: 0.5,
                         angle: 180
                        }
                     )
                }
         '],
         ['
         ']
         )
\TLV iceboard_sseg(|_pipe, @_stage, $_digit, $_sseg, $_dp)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         \viz_alpha
            initEach() {
                  
                  let sseg_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/ice_sseg.png?raw=true"
                  let sseg_img = new fabric.Image.fromURL(
                        sseg_img_url,
                        function (img) {
                           global.canvas.add(img)
                           global.canvas.sendToBack(img);
                        },
                        {originX: "center",
                         originY: "center",
                         left: 155,
                         top: 10,
                         scaleX: 0.3,
                         scaleY: 0.3,
                        }
                     )
                   
                   let seg = new fabric.Rect({
                     top: -60,
                     left: 130,
                     width: 176, 
                     height: 140, 
                     fill: "black",
                     opacity: 1
                  })
                return {objects :{seg}};
                }
                
         '],
         ['
         ']
         )
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         
         /digit[1:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: 42,
                           left: (scopes.digit.index == 0) ? 270 : 195 ,
                           radius: 4,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: -10 + ((scopes.led.index == 5) ? -28 : (scopes.led.index == 4) ? 16 : (scopes.led.index == 3) ? 54 : (scopes.led.index == 2) ? 16 : (scopes.led.index == 1) ? -28 : (scopes.led.index == 0) ? 10 : -30),
                           left: ((scopes.digit.index == 0) ? 240 : 165) + ((scopes.led.index == 5) ? 26 : (scopes.led.index == 4) ? 19 : (scopes.led.index == 3) ? -12 : (scopes.led.index == 2) ? -20 : (scopes.led.index == 1) ? -13 : (scopes.led.index == 6) ? 1 : -5),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 30 : 6,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 40 : 6,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg}};
                  },
                  renderEach() {
                     var enable = ('/top|_pipe$_digit'.asBinaryStr().split("").reverse().join(""));
                     var dp = ('/top|_pipe$_dp'.asBinaryStr());
                     this.getInitObject("sseg").bringToFront()
                     var sseg1 = ('/top|_pipe$_sseg'.asBinaryStr());
                     var fp_valid = dp == 0
                     if(scopes.led.index == 7)
                     {
                        this.getInitObject("sseg").set(enable[scopes.digit.index] == 0 && fp_valid ? {fill: "red"} : {fill: "grey"})
                     }
                     else {
                        var hamm = ((('/top|_pipe$_sseg'.asInt(-1) >> scopes.led.index) & 1) == 0);
                        this.getInitObject("sseg").set(hamm && (enable[scopes.digit.index] == 0) ? {fill: "red"} : {fill: "grey"});
                     }
                  }
          
         '],
         ['
         ']
         )
         
\TLV nexys_init(|_pipe, @_stage)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         \viz_alpha
            initEach() {
                  let fpga_img_url = "https://github.com/BalaDhinesh/Virtual-FPGA-Lab/blob/main/images/NEXYS_A7.png?raw=true"
                  let fpga_img = new fabric.Image.fromURL(
                        fpga_img_url,
                        function (img) {
                           global.canvas.add(img)
                           global.canvas.sendToBack(img);
                        },
                        {originX: "center",
                         originY: "center",
                         scaleX: 1,
                         scaleY: 1,
                        }
                     )
                let seg = new fabric.Rect({
                     top: 90,
                     left: -126,
                     width: 218, 
                     height: 35, 
                     fill: "black",
                     opacity: 1
                  })
                
                return {objects :{seg}};
             }
         /digit[7:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: 119,
                           //left: (scopes.digit.index == 3) ? -122 : (scopes.digit.index == 0) ? -212 : (scopes.digit.index == 1) ? -182 : -152 ,
                           left : ((scopes.digit.index == 7) ? -104 : (scopes.digit.index == 6) ? -79 : (scopes.digit.index == 5) ? -54 : (scopes.digit.index == 4) ? -29 : (scopes.digit.index == 3) ? 6 : (scopes.digit.index == 2) ? 31 : (scopes.digit.index == 1) ? 56 : 81),
                           radius: 2,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: 76 + ((scopes.led.index == 5) ? 19 : (scopes.led.index == 4) ? 32 : (scopes.led.index == 3) ? 43 : (scopes.led.index == 2) ? 32 : (scopes.led.index == 1) ? 19 : (scopes.led.index == 0) ? 30 : 18),
                           left: ((scopes.digit.index == 7) ? -114 : (scopes.digit.index == 6) ? -89 : (scopes.digit.index == 5) ? -64 : (scopes.digit.index == 4) ? -39 : (scopes.digit.index == 3) ? -4 : (scopes.digit.index == 2) ? 21 : (scopes.digit.index == 1) ? 46 : 71) + ((scopes.led.index == 5) ? 10 : (scopes.led.index == 4) ? 8 : (scopes.led.index == 3) ? -4 : (scopes.led.index == 2) ? -8 : (scopes.led.index == 1) ? -6 : (scopes.led.index == 0) ? -2 : -1),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 12 : 3,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 11 : 3,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg}};
                  },
         '],
         ['
         ']
         )
\TLV nexys_led(|_pipe, @_stage, $_leds)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         //$viz_leds[15:0] = {$L1,$P1,$N3,$P3,$U3,$W3,$V3,$V13,$V14,$U14,$U15,$W18,$V19,$U19,$E19,$U16};
         /led[15:0]
            \viz_alpha
               initEach() {
                  let led = new fabric.Rect({
                        top: 128,
                        left: 185 - 21.2 * (this.getIndex() + 1),
                        width: 8, 
                        height: 8, 
                        fill: "red",
                        opacity: 0
                     })
                  /*let done_led = new fabric.Rect({
                        top: -108,
                        left: 191, 
                        width: 5, 
                        height: 8, 
                        fill: "green",
                        opacity: 1
                     }) */
                  return{objects : {led /*, done_led*/}}; 
               }, 
               renderEach() {
                     var mod = ((('/top|_pipe$_leds'.asInt(-1) >> this.getScope("led").index) & 1) == 1);
                     console.log('/top|_pipe$_leds'.asInt(-1))
                     this.getInitObject("led").set(mod ? {opacity: 1} : {opacity: 0});
                  }   
         '],
         ['
         ']
         )
\TLV nexys_sseg(|_pipe, @_stage, $_digit, $_sseg, $_dp)
   |_pipe
      @_stage
         m4_ifelse_block(M4_MAKERCHIP, 1, ['
         
         /digit[7:0]
            /led[7:0]
               \viz_alpha
                  initEach() {
                     let sseg = (scopes.led.index == 7) ? new fabric.Circle({
                           top: 119,
                           //left: (scopes.digit.index == 3) ? -122 : (scopes.digit.index == 0) ? -212 : (scopes.digit.index == 1) ? -182 : -152 ,
                           left : ((scopes.digit.index == 7) ? -104 : (scopes.digit.index == 6) ? -79 : (scopes.digit.index == 5) ? -54 : (scopes.digit.index == 4) ? -29 : (scopes.digit.index == 3) ? 6 : (scopes.digit.index == 2) ? 31 : (scopes.digit.index == 1) ? 56 : 81),
                           radius: 2,
                           opacity: 1,
                           fill: "grey"
                        }) 
                        :
                        new fabric.Rect({
                           top: 76 + ((scopes.led.index == 5) ? 19 : (scopes.led.index == 4) ? 32 : (scopes.led.index == 3) ? 43 : (scopes.led.index == 2) ? 32 : (scopes.led.index == 1) ? 19 : (scopes.led.index == 0) ? 30 : 18),
                           left: ((scopes.digit.index == 7) ? -114 : (scopes.digit.index == 6) ? -89 : (scopes.digit.index == 5) ? -64 : (scopes.digit.index == 4) ? -39 : (scopes.digit.index == 3) ? -4 : (scopes.digit.index == 2) ? 21 : (scopes.digit.index == 1) ? 46 : 71) + ((scopes.led.index == 5) ? 10 : (scopes.led.index == 4) ? 8 : (scopes.led.index == 3) ? -4 : (scopes.led.index == 2) ? -8 : (scopes.led.index == 1) ? -6 : (scopes.led.index == 0) ? -2 : -1),
                           width: ((this.getIndex() == 6) || (this.getIndex() == 3) || (this.getIndex() == 0)) ? 12 : 3,
                           height: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? 11 : 3,
                           fill: "grey",
                           skewX: ((this.getIndex() == 5) || (this.getIndex() == 4) || (this.getIndex() == 2) || (this.getIndex() == 1)) ? -9 : 0,
                           opacity: 1
                        })
                     return{objects : {sseg}};
                  },
                  renderEach() {
                     var enable = ('/top|_pipe$_digit'.asBinaryStr().split("").reverse().join(""));
                     this.getInitObject("sseg").bringToFront()
                     var sseg1 = ('/top|_pipe$_sseg'.asBinaryStr());
                     var fp_valid = '/top|_pipe$_dp'.asBool() == 0
                     if(scopes.led.index == 7)
                     {
                        this.getInitObject("sseg").set(enable[scopes.digit.index] == 0 && fp_valid ? {fill: "red"} : {fill: "grey"})
                     }
                     else {
                        var hamm = ((('/top|_pipe$_sseg'.asInt(-1) >> scopes.led.index) & 1) == 0);
                        this.getInitObject("sseg").set(hamm && enable[scopes.digit.index] == 0 ? {fill: "red"} : {fill: "grey"});
                     }
                  }
          
         '],
         ['
         ']
         )
