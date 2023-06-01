module top (
    input PIN_11,
    input PIN_12,
    output LED
);
    nand_gate nand_instance (
        .a(PIN_11),
        .b(PIN_12),
        .out(LED)
    );
endmodule
