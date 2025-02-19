module instruction_memory #(
    parameter MEM_SIZE = 4095,
    parameter MEM_INIT_FILE = "imemory_2.txt"
    // parameter MEM_INIT_FILE = "imemory.txt"
) (
    input wire clk,
    input wire reset,  // Added reset signal
    input wire [63:0] addr,
    output wire [31:0] instr
);
    // Memory array
    reg [7:0] mem [0:MEM_SIZE-1];
    
    // File reading variables
    integer file, status, i;
    integer decimal_value;
    
    // Initialize memory from file
    initial begin
        // Clear memory
        for (i = 0; i < MEM_SIZE; i = i + 1)
            mem[i] = 0;
            
        // Read from file
        file = $fopen(MEM_INIT_FILE, "r");
        if (!file) begin
            $display("Error: Could not open %s", MEM_INIT_FILE);
            $finish;
        end
        
        i = 0;
        while (!$feof(file) && i < MEM_SIZE) begin
            status = $fscanf(file, "%d", decimal_value);
            if (status == 1 && decimal_value >= 0 && decimal_value <= 255) begin
                mem[i] = decimal_value;
                i = i + 1;
            end
        end
        
        $fclose(file);
        $display("Loaded %0d bytes from %s", i, MEM_INIT_FILE);
    end

    reg [31:0] tmp;
    assign instr = tmp;

    // Read instruction with reset (little-endian)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            tmp <= 32'h0;  // Reset the instruction register to zero
        end else begin
            tmp <= {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr+0]};
        end
    end

endmodule