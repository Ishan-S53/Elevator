module elevator_tb;
    reg clk;
    reg rst;
    reg [3:0] request_floor;
    wire [3:0] current_floor;
    wire moving;
    wire direction;

    // Instantiate the elevator module
    elevator uut (
        .clk(clk),
        .rst(rst),
        .request_floor(request_floor),
        .current_floor(current_floor),
        .moving(moving),
        .direction(direction)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        request_floor = 0;
        #10 rst = 0;

        // Request floor 5
        #10 request_floor = 4'd5;
        #50;
        
        // Request floor 2
        #10 request_floor = 4'd2;
        #50;
        
        // Request same floor (should not move)
        #10 request_floor = 4'd2;
        #20;

        // Request highest floor 9
        #10 request_floor = 4'd9;
        #60;
        
        // Reset elevator
        #10 rst = 1;
        #10 rst = 0;
        
        #100 $stop;
    end
endmodule
