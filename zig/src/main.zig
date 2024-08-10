const std = @import("std");
const fs = std.fs;
const mem = std.mem;

const ReadditError = error{InvalidArgument};

pub fn main() !void {
    const start = std.time.milliTimestamp();

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var input_file: ?[]u8 = null;
    for (args, 0..) |arg, i| {
        if (mem.eql(u8, arg, "--input") or mem.eql(u8, arg, "-i")) {
            if (args.len <= (i + 1)) {
                return error.InvalidArgument;
            }
            input_file = args[i + 1];
            break;
        }
        if (mem.startsWith(u8, arg, "--input=")) {
            input_file = arg["--input=".len..];
            break;
        }
        if (mem.startsWith(u8, arg, "-i=")) {
            input_file = arg["-i=".len..];
            break;
        }
    }

    const filepath = input_file orelse return error.InvalidArgument;

    if (filepath.len == 0) {
        return error.InvalidArgument;
    }
    const file = try fs.cwd().openFile(filepath, .{ .mode = fs.File.OpenMode.read_only });
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var reader = buf_reader.reader();

    var lines: usize = 0;
    var chars: usize = 0;

    var buf: [1024]u8 = undefined;
    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        lines += 1;
        chars += line.len;
    }
    const dur = std.time.milliTimestamp() - start;
    std.debug.print("The input file contains {d} lines of text and {d} characters. The execution of this script took {d} ms.\n", .{ lines, chars, dur });
}
