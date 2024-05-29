const std = @import("std");
const c = @cImport({
    @cInclude("msgpuck.h");
});

pub fn main() !void {
    var buf: [1024]u8 = undefined;
    var w: [*c]u8 = &buf;
    w = c.mp_encode_array(w, 4);
    w = c.mp_encode_uint(w, 10);
    w = c.mp_encode_str(w, "hello world", "hello world".len);
    w = c.mp_encode_bool(w, true);
    w = c.mp_encode_double(w, 3.1415);

    const encoded_size = buf.len - std.mem.len(w);
    const encoded_data = buf[0..encoded_size];

    std.debug.print("Encoded data: ", .{});
    for (encoded_data) |byte| {
        std.debug.print("{X:0>2} ", .{byte});
    }
    std.debug.print("\n", .{});
}
