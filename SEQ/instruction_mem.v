// Reads hex values
module instruction_memory #(
    parameter MEM_SIZE = 4095,
    parameter MEM_INIT_FILE = "Test_hazard_15.txt"
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
    reg [7:0] hex_value;
    
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
            status = $fscanf(file, "%h", hex_value); // Changed to %h for hex format
            if (status == 1) begin
                mem[i] = hex_value;
                i = i + 1;
            end
        end
        
        $fclose(file);
        $display("Loaded %0d bytes from %s", i, MEM_INIT_FILE);
    end

    reg [31:0] tmp;
    assign instr = tmp;

    always @(*) 
    begin
        tmp = {mem[addr+0], mem[addr+1], mem[addr+2], mem[addr+3]};
    end

endmodule