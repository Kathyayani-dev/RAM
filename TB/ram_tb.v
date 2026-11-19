# code for ram_tb.v
  ...
     module ram_tb;
   wire [7:0] data;
   reg  [3:0] addr;
   reg  we,enable;
   reg  [7:0] tempd;

   integer l;

   //Step1 : Instantiate the RAM module and connect the ports
        ram DUT(we,enable,addr,data);

   //Understand how the wire data acts like an input during write operation
   assign data=(we && !enable) ? tempd : 8'hzz;

    //Tasks for Initialising the inputs
   task initialize();
      begin
         we=1'b0; enable=1'b0; tempd=8'h00;
      end
   endtask

   /*Step2 : Write a task named "stimulus" to assign data into^M
   "addr" and "tempd" inputs through i and j variables*/
        task stimulus([3:0]i,[7:0]j);
                begin
                        addr=i;
                        tempd=j;
                end
        endtask


   //Understand the various tasks used in this testbench
   task write();
      begin
         we=1'b1;
         enable=1'b0;
      end
   endtask

       task read();
      begin
         we=1'b0;
         enable=1'b1;
      end
   endtask

   task delay;
      begin
         #10;
      end
   endtask

   //Process to generate stimulus using for loop
   initial
      begin
         initialize;
         delay;
         write;
         for(l=0;l<16;l=l+1)
            begin
               stimulus(l,l);
               delay;
            end
         initialize;
         delay;
         read;
         for(l=0;l<16;l=l+1)
            begin
               stimulus(l,l);
               delay;
            end
         delay;
         $finish;
      end

 //Waveform dump
  /* initial
    begin
     $fsdbDumpvars(0,ram_tb);
    end*/



endmodule
...
