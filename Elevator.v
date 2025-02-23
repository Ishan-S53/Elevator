module elevator (
    input clk,                  // Clock signal
    input rst,                  // Reset signal
    input [3:0] request_floor,   // Floor request (0-9)
    output reg [3:0] current_floor, // Current floor indicator
    output reg moving,           // Elevator moving status
    output reg direction         // Direction (1: Up, 0: Down)
);

    reg [3:0] target_floor;      // Target floor storage

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_floor <= 4'd0; // Reset to ground floor
            moving <= 0;
            target_floor <= 4'd0;
        end 
        else begin
            if (request_floor != current_floor) begin
                target_floor <= request_floor;
                moving <= 1;
                direction <= (request_floor > current_floor) ? 1 : 0;
            end 
            else begin
                moving <= 0;
            end

            if (moving) begin
                if (direction && current_floor < target_floor)
                    current_floor <= current_floor + 1;
                else if (!direction && current_floor > target_floor)
                    current_floor <= current_floor - 1;
                else
                    moving <= 0; // Stop when target is reached
            end
        end
    end
endmodule
